%% ========= Merge monthly Summary_StdOps_20XXXX into one markdown =========
clear; clc;

% Root directory:
% It contains multiple subfolders like "Cluster_202410", "Cluster_202411", ...
rootDir   = '../Dataset';
outputDir = '../Dataset/Inconsistency_dataset';

% Create the output directory if it does not exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Output markdown file name
outMd = fullfile(outputDir, 'BESS_inconsistency_dataset.md');

% Remove old file if it already exists
if exist(outMd, 'file')
    delete(outMd);
end

% ========== 1. Find all "Cluster_20XXXX" subfolders ==========
d = dir(rootDir);
isSub = [d.isdir] & ~ismember({d.name}, {'.','..'});
subFolders = d(isSub);

% Keep only folders whose name starts with "Cluster_20"
maskCluster = startsWith({subFolders.name}, 'Cluster_20');
subFolders = subFolders(maskCluster);

if isempty(subFolders)
    error('No "Cluster_20XXXX" subfolders found under %s. Please check rootDir.', rootDir);
end

% Sort by folder name
[~, idxSort] = sort({subFolders.name});
subFolders = subFolders(idxSort);

% Open markdown file (UTF-8)
fid = fopen(outMd, 'w', 'n', 'UTF-8');
assert(fid > 0, 'Cannot create markdown file: %s', outMd);

% ========== 2. Process each monthly folder ==========
for iSub = 1:numel(subFolders)
    folderName = subFolders(iSub).name;               % e.g. 'Cluster_202410'
    monthDir   = fullfile(rootDir, folderName);
    fprintf('Processing folder: %s\n', monthDir);

    % ---------- 2.1 Find Summary_StdOps_20XXXX*.mat ----------
    infoSum = dir(fullfile(monthDir, 'Summary_StdOps_*.mat'));
    if isempty(infoSum)
        warning('No Summary_StdOps_*.mat found in %s. Skipped.', monthDir);
        continue;
    end
    matSummary = fullfile(monthDir, infoSum(1).name);

    % In the .mat file, find a variable whose name contains "Summary_StdOps"
    varsSum = whos('-file', matSummary);
    idxSumVar = find(contains({varsSum.name}, 'Summary_StdOps'), 1);
    if isempty(idxSumVar)
        warning('No variable containing "Summary_StdOps" found in %s. Skipped.', matSummary);
        continue;
    end
    sumVarName = varsSum(idxSumVar).name;

    tmpSum = load(matSummary, sumVarName);
    Summary_StdOps = tmpSum.(sumVarName);

    % ---- Check if SOH_pack exists as a table column ----
    SOH_pack_all = [];
    if ismember('SOH_pack', Summary_StdOps.Properties.VariableNames)
        SOH_pack_all = Summary_StdOps.SOH_pack;   % could be nOp×1, nOp×nRack, or cell
    else
        % Backward compatibility: SOH_pack stored as a separate variable in the .mat file
        idxSOH = find(contains({varsSum.name}, 'SOH_pack'), 1);
        if ~isempty(idxSOH)
            sohVarName = varsSum(idxSOH).name;
            tmpSOH = load(matSummary, sohVarName);
            SOH_pack_all = tmpSOH.(sohVarName);
        end
    end

    % Rack names: try reading from UserData; otherwise create {'Rack1',...,'Rack9'}
    if isfield(Summary_StdOps.Properties, 'UserData') && ...
            isfield(Summary_StdOps.Properties.UserData, 'rackNames') && ...
            ~isempty(Summary_StdOps.Properties.UserData.rackNames)
        rackNames = Summary_StdOps.Properties.UserData.rackNames;
    else
        nRack = 9;
        rackNames = arrayfun(@(k) sprintf('Rack%d',k), 1:nRack, 'UniformOutput', false);
    end
    nRack = numel(rackNames);

    % ---------- 2.2 Find OperationCondition_20XXXX_All.mat ----------
    infoOC = dir(fullfile(monthDir, 'OperationCondition_*_All.mat'));
    if isempty(infoOC)
        warning('No OperationCondition_*_All.mat found in %s. Skipped.', monthDir);
        continue;
    end
    matOC = fullfile(monthDir, infoOC(1).name);

    varsInOC  = whos('-file', matOC);
    idxStruct = find(strcmp({varsInOC.class}, 'struct'), 1);
    if isempty(idxStruct)
        warning('No struct variable found in %s. Skipped.', matOC);
        continue;
    end
    ocVarName = varsInOC(idxStruct).name;
    tmpOC = load(matOC, ocVarName);
    OperationCondition_All = tmpOC.(ocVarName);

    % ---------- 2.3 Write each operation into markdown (strict format) ----------
    nOp = height(Summary_StdOps);

    for iOp = 1:nOp
        opName = Summary_StdOps.Operation{iOp};     % e.g. 'Operation3'

        if ~isfield(OperationCondition_All, opName)
            warning('%s does not contain %s. This operation is skipped.', ocVarName, opName);
            continue;
        end

        opStruct = OperationCondition_All.(opName);

        % Operation type ('Charge' / 'Discharge' / ...)
        if isfield(opStruct, 'Type')
            typeStr = char(opStruct.Type);
        else
            typeStr = '';
        end

        % Convert to 'charging' / 'discharging'
        tLower = lower(typeStr);
        if contains(tLower, 'charge')
            opTypeOut = 'charging';
        elseif contains(tLower, 'discharge')
            opTypeOut = 'discharging';
        else
            opTypeOut = tLower;
        end

        % Date and time
        startTime = opStruct.StartTime;
        endTime   = opStruct.EndTime;

        dateStrHeader = datestr(startTime, 'yyyy.mm.dd');   % used for "# 2025.01.01"
        dateStrLine   = dateStrHeader;                      % used for "date: 2025.01.01"
        timeStr       = sprintf('%s-%s', ...
            datestr(startTime, 'HH:MM'), datestr(endTime, 'HH:MM'));

        % -------- Voltage inconsistency: 3×nRack --------
        dVmax   = nan(1, nRack);
        dVmean  = nan(1, nRack);
        badCnt  = nan(1, nRack);

        for r = 1:nRack
            rn = rackNames{r};
            colMax  = sprintf('%s_dVmax',  rn);
            colMean = sprintf('%s_dVmean', rn);
            colBad  = sprintf('%s_badCount', rn);

            if ismember(colMax, Summary_StdOps.Properties.VariableNames)
                dVmax(r)  = Summary_StdOps.(colMax)(iOp);
            end
            if ismember(colMean, Summary_StdOps.Properties.VariableNames)
                dVmean(r) = Summary_StdOps.(colMean)(iOp);
            end
            if ismember(colBad, Summary_StdOps.Properties.VariableNames)
                badCnt(r) = Summary_StdOps.(colBad)(iOp);
            end
        end

        % -------- Thermal inconsistency: 3×nRack --------
        dTmax   = nan(1, nRack);
        dTmean  = nan(1, nRack);
        CTmean  = nan(1, nRack);

        for r = 1:nRack
            rn = rackNames{r};
            colTmax  = sprintf('%s_dTmax',  rn);
            colTmean = sprintf('%s_dTmean', rn);
            colCT    = sprintf('%s_CTmean', rn);

            if ismember(colTmax, Summary_StdOps.Properties.VariableNames)
                dTmax(r)  = Summary_StdOps.(colTmax)(iOp);
            end
            if ismember(colTmean, Summary_StdOps.Properties.VariableNames)
                dTmean(r) = Summary_StdOps.(colTmean)(iOp);
            end
            if ismember(colCT, Summary_StdOps.Properties.VariableNames)
                CTmean(r) = Summary_StdOps.(colCT)(iOp);
            end
        end

        % -------- Health vector: prefer Rack1_SOH ~ RackN_SOH --------
        health     = nan(1, nRack);
        hasRackSOH = false;

        % Prefer reading Rack*_SOH columns from Summary_StdOps
        for r = 1:nRack
            colSOH = sprintf('%s_SOH', rackNames{r});   % e.g. 'Rack3_SOH'
            if ismember(colSOH, Summary_StdOps.Properties.VariableNames)
                health(r) = Summary_StdOps.(colSOH)(iOp);
                hasRackSOH = true;
            end
        end

        % If no Rack*_SOH exists (older versions), fall back to SOH_pack_all
        if ~hasRackSOH && ~isempty(SOH_pack_all)
            if isnumeric(SOH_pack_all)
                % Case 1: nOp × nRack (one row per operation)
                if size(SOH_pack_all,1) == nOp && size(SOH_pack_all,2) == nRack
                    health = SOH_pack_all(iOp, :);

                % Case 2: nOp × 1 (one scalar SOH per operation)
                elseif size(SOH_pack_all,1) == nOp && size(SOH_pack_all,2) == 1
                    health = repmat(SOH_pack_all(iOp,1), 1, nRack);

                % Case 3: 1 × nRack (one vector independent of operation)
                elseif size(SOH_pack_all,1) == 1 && size(SOH_pack_all,2) == nRack
                    health = SOH_pack_all;

                else
                    warning('SOH_pack has unexpected numeric size %dx%d.', ...
                        size(SOH_pack_all,1), size(SOH_pack_all,2));
                    health = nan(1, nRack);
                end

            elseif iscell(SOH_pack_all)
                % Case 4: SOH_pack is a cell column, each row contains a vector
                if numel(SOH_pack_all) >= iOp && ~isempty(SOH_pack_all{iOp})
                    h = SOH_pack_all{iOp};
                    if isnumeric(h) && isvector(h)
                        h = h(:).';
                        if numel(h) == nRack
                            health = h;
                        else
                            % If only a scalar is available, replicate it to nRack
                            health = repmat(h(1), 1, nRack);
                        end
                    end
                end
            end
        end

        % =================== Write into markdown ===================
        % Example format:
        % # 2025.01.01
        % date: 2025.01.01
        % time: 09:00-10:00
        % operation: charging
        fprintf(fid, '# %s\n', dateStrHeader);
        fprintf(fid, 'date: %s\n', dateStrLine);
        fprintf(fid, 'time: %s\n', timeStr);
        fprintf(fid, 'operation: %s\n\n', opTypeOut);

        % Voltage inconsistency
        fprintf(fid, 'voltage inconsistency：\n');
        fprintf(fid, 'V = ');
        write_matrix_3xN(fid, dVmax, dVmean, badCnt);
        fprintf(fid, '\n');

        % Temperature inconsistency
        fprintf(fid, 'temperature inconsistency：\n');
        fprintf(fid, 'T = ');
        write_matrix_3xN(fid, dTmax, dTmean, CTmean);
        fprintf(fid, '\n');

        % Health
        fprintf(fid, 'health：\n');
        fprintf(fid, 'H = %s\n', row_to_list(health));

        fprintf(fid, '\n\n');   % blank line between slices
    end
end

fclose(fid);
fprintf('\nDone. Markdown saved to: %s\n', outMd);

%% ===== Utility: convert a row vector to "[a, b, c]" string =====
function s = row_to_list(x)
    if isempty(x)
        s = '[]';
        return;
    end
    x = x(:).';           % force row
    fmt = '%.6g';          % numeric format
    parts = arrayfun(@(v) sprintf(fmt, v), x, 'UniformOutput', false);
    s = ['[', strjoin(parts, ', '), ']'];
end

% ===== Utility: write 3 rows as "[row1; \n row2; \n row3]" =====
function write_matrix_3xN(fid, row1, row2, row3)
    s1 = row_to_list_no_bracket(row1);
    s2 = row_to_list_no_bracket(row2);
    s3 = row_to_list_no_bracket(row3);

    % Output format:
    % [a, b, c;
    %  d, e, f;
    %  g, h, i]
    fprintf(fid, '[%s; \n', s1);
    fprintf(fid, '%s; \n', s2);
    fprintf(fid, '%s]\n',  s3);
end

function s = row_to_list_no_bracket(x)
    if isempty(x)
        s = '';
        return;
    end
    x = x(:).';
    fmt = '%.6g';
    parts = arrayfun(@(v) sprintf(fmt, v), x, 'UniformOutput', false);
    s = strjoin(parts, ', ');
end
