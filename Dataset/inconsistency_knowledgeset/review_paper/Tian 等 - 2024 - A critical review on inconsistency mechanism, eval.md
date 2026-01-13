# Material and design non-uniformity create initial parameter spread (Q, R, OCV, SDR, CE)  
Small differences in electrode thickness, particle morphology, electrolyte amount and separator thickness change capacity, internal resistance and polarization, leading to different OCV, SDR and coulomb efficiency even within one batch. Shell stiffness and alloy composition further modulate gas-induced swelling and mechanical constraint, so cells leave the factory with intrinsic spread in Q, R, OCV and aging behavior.

# Manufacturing variability drives resistance, capacity and self-discharge inconsistency  
Uncontrolled variations in ambient temperature, humidity, coating thickness, mixing uniformity, rolling density and tab welding quality produce cells with different internal resistance, maximum usable capacity and self-discharge rate. Imperfect sealing, drying, electrolyte injection and formation conditions (non-uniform temperature or current) lead to non-uniform SEI films and moisture/air ingress, amplifying cell-to-cell differences in DCIR, SDR and cycle life.  

# Usage conditions and topology induce secondary parameter divergence  
Cell position in the pack, air/liquid flow non-uniformity and pre-heating differences cause temperature gradients, which in turn change internal resistance, OCV and effective capacity among cells. Contact resistance dispersion produces uneven cell currents (especially in parallel branches), feeding back into different I²R heating, SOC drift and aging rates across the pack.  

# Inconsistency feedback loop couples parameters, states and external behavior  
Material and manufacturing differences first set a spread in parameters (Q, R, OCV, SDR, CE), then grouping topology and thermal field convert these into electrical (V, I, SOP), thermal (T distribution) and aging (SOH, DR, RUL) inconsistencies. These non-uniform behaviors further accelerate divergence of internal parameters over time, forming a positive feedback loop of worsening inconsistency.  

# Lowest capacity or highest resistance cell governs overcharge and overdischarge risk  
In a series pack, the cell with the smallest capacity reaches full charge or full discharge first, so BMS cutoffs based on pack voltage or a single cell voltage cause that “weakest” cell to be overcharged or overdischarged while others remain within limits. Cells with larger internal resistance or higher OCV platform also hit cut-off voltages earlier under the same current, making them local hot spots for stress and failure.  

# Ohmic resistance mismatch generates local overheating and safety hazards  
Cells with higher internal resistance dissipate more ohmic heat under the same current, so they run hotter than neighbors and are prone to local overheating when cooling is non-uniform. Accumulated hot spots from such cells can trigger thermal events (smoke, fire, explosion, thermal runaway), especially when series-connected cells force equal current through mismatched resistances.  

# Barrel effect: pack usable capacity limited by weakest cell SOC window  
During charging, BMS must stop when any cell hits the upper voltage limit, leaving higher-capacity cells undercharged; during discharge it must stop when any cell reaches the lower voltage limit, leaving residual capacity in stronger cells. This “barrel effect” means the true capacity of the pack is capped by the smallest effective cell capacity, directly reducing available energy.  

# Resistance and SOC mismatch reduce available power via early voltage constraints  
Under dynamic load, cells with higher internal resistance show larger instantaneous voltage drops, so their terminal voltages hit power-constraining limits earlier than others. Inconsistent SOC distributions have a similar effect: cells closer to empty or full impose voltage limits first, reducing pack-level charge and discharge power.  

# Temperature above 35 °C strongly accelerates electrolyte decomposition and lithium deposition  
Capacity fade is highly temperature dependent: when ambient temperature exceeds 35 °C, electrolyte decomposition and active lithium deposition are accelerated. Local heat accumulation in parts of the pack keeps some cells at elevated temperature for long periods, causing their capacity and SOH to decay significantly faster than cooler cells.  

# Shallow over-discharge decomposes SEI and consumes active lithium  
Cell capacity mismatch in a pack can drive individual cells into shallow over-discharge even when pack-level limits are respected. Over-discharge decomposes the SEI film; subsequent regeneration of fresh SEI consumes active lithium and electrolyte, accelerating capacity loss in those cells relative to others.  

# Slight overcharge promotes lithium plating and life divergence  
Even small overcharge beyond normal limits leads to lithium plating on electrodes, which is identified as a mechanism for accelerated capacity decay. Cells that experience repeated slight overcharge (because of SOC/OCV mismatch in the pack) age faster, so the dispersion in SOH and capacity widens with cycle count.  

# Life decay rate divergence grows with operating time  
Cells under “normal” conditions show relatively slow degradation, whereas cells exposed to high temperature, overcharge or over-discharge degrade much faster. Over long service time this difference in decay rate becomes increasingly pronounced, leading to substantial spread in SOH, capacity and DCIR within the same pack.  

# Statistical indicators (variance, standard deviation, range) quantify voltage inconsistency  
Variance, standard deviation and range of cell voltages, currents, temperatures or internal parameters are used as simple dispersion measures of inconsistency. An industrial standard defines five consistency levels; a voltage standard deviation coefficient ≤ 1.5 % is regarded as optimal pack consistency.  

# 3σ criterion and voltage range enable abnormal-cell detection and equalization triggering  
Standard deviation of voltage or capacity with a 3σ rule allows identification of cells with abnormal performance relative to the fleet. Voltage range across cells serves as a practical trigger for active equalization control, while changes in variance coefficients before/after balancing quantify equalization effectiveness.  

# Multi-feature weighting fuses voltage, temperature, resistance, capacity and ICA features  
Single features like voltage cannot fully represent pack health, so multi-feature schemes combine voltage, temperature, internal resistance, capacity, current and incremental capacity-curve features. Entropy-weighting or analytic hierarchy process assign weights to each feature to form a scalar consistency index that reflects electrical, thermal and aging behavior simultaneously.  

# Machine-learning models map multi-dimensional features to consistency metrics  
Neural-network–based models (GAN, LSTM, autoencoders, deep belief networks) use features such as R, SOC, V, I to estimate parameter consistency, branch currents or voltage inconsistency. These models capture nonlinear relationships and spatiotemporal patterns in pack data, enabling more accurate and holistic assessment of inconsistency than simple statistics.  

# Clustering-based sorting groups cells with similar Q, R, OCV, SOC, T and RUL  
Unsupervised clustering methods (K-means and its variants, SOM, time-series clustering, fuzzy C-means, DBSCAN) classify cells using combinations of capacity, internal resistance, OCV, SOC, voltage time series, temperature and RUL. Grouping cells with similar electrochemical and thermal behavior into the same module reduces internal parameter spread and improves pack voltage and SOC consistency.  

# Multi-level sorting of retired cells narrows performance spread for second-life packs  
For retired cells with mixed specifications and histories, multi-level sorting first removes mechanically damaged cells, then separates “energy-type” and “power-type” cells by capacity and resistance, and finally refines groups using additional features like voltage and temperature. This hierarchical process yields second-life packs with narrower parameter distributions and more uniform voltage behavior.  

# Cell placement and topology optimization significantly reduce SOC and voltage spread  
In a 2S2P pack tested under UDDS at 25 °C, re-allocating four cells with different Q and R reduced the final SOC spread from about 9.7 % (unoptimized) to near zero and cut end-of-discharge voltage deviation from 0.146 V to almost zero. In a 2P2S pack, similar topology optimization reduced maximum SOC deviation from ~10.8 % and voltage deviation from 0.169 V to negligible levels, demonstrating that optimal cell placement strongly improves pack voltage and SOC consistency.  

# Flexible reconfiguration maintains pack voltage and energy consistency under cell faults  
Switch-matrix–based flexible reorganization allows cells to be dynamically inserted or bypassed in series/parallel networks using relays or MOSFETs. By reconfiguring the network in response to abnormal cells or changing load demands, the pack can maintain more uniform voltages and SOC distribution while continuing operation.  

# Passive shunt equalization reduces voltage spread but wastes energy  
Fixed shunt-resistor schemes continuously bleed current proportional to cell voltage, eventually aligning cell voltages but also dissipating pack energy even after equalization is reached. Switched shunt-resistor schemes add control logic so only high-voltage cells are discharged, cutting unnecessary losses while still reducing voltage variance.  

# Active equalization uses inductors, transformers, capacitors or converters to redistribute energy  
Inductor- and transformer-based topologies move charge from higher-voltage or higher-SOC cells to lower ones, while capacitor-based and converter-based schemes (e.g., Boost, Flyback, Cuk) perform similar energy transfers at cell or module level. These architectures target tighter voltage/SOC consistency with higher efficiency and speed than passive methods, at the cost of added complexity.  

# Hybrid equalization combines passive and active paths for efficiency and accuracy  
Hybrid schemes use passive resistors to quickly bleed small excess energies and active DC/DC or transformer paths to replenish low-voltage cells. Multi-level hybrids (module-level transformer plus cell-level Buck–Boost, for example) achieve fast, efficient voltage and SOC equalization across large packs and retired-cell systems.  

# Advanced thermal management reduces temperature-driven parameter divergence  
Natural convection is low-cost but only suitable for small packs because of low heat-transfer coefficients and poor uniformity. Forced air cooling improves heat removal via high-velocity air but has noise and energy penalties; liquid cooling further increases heat-transfer coefficient and temperature uniformity, while PCM-based systems offer high cooling efficiency and excellent temperature uniformity but with higher cost and maintenance complexity.  

# Cooling strategy choice directly impacts voltage and aging consistency  
Optimized air-duct geometry and cell spacing, or well-designed liquid channels (inlet velocity, channel number, contact angle), can significantly homogenize temperature distribution, reducing temperature-induced differences in R, OCV, SOC and degradation rate. PCM-filled gaps between cells further suppress temperature gradients, helping stabilize voltage behavior and slow divergence in SOH across the pack.
