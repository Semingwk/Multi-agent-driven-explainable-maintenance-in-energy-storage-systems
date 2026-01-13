# Lithium-ion batteries in large energy storage systems exhibit unique system-level hazards beyond cell-level behavior

Large battery systems amplify risks because individual cell tolerance to off-nominal conditions does not translate to pack-level robustness. Nonuniform aging, resistance drift, and thermal variation between thousands of cells compound deviations that push specific cells into unsafe voltage or temperature ranges. These escalated stresses raise the likelihood of venting, fire, and explosion. Gaseous byproducts accumulating inside enclosures can transition small deflagrations into large detonations, emphasizing that system architecture and enclosure conditions dominate safety outcomes.

# Electrical abuse modes such as overcharge destabilize electrodes and trigger thermal runaway

Charging above recommended voltage or current destabilizes the cathode, accelerates electrolyte decomposition, and promotes lithium dendrite formation, all of which generate heat. Aging increases internal resistance mismatch across cells, causing some cells to exceed voltage limits even when overall pack voltage appears nominal. Pouch cells lacking internal interrupt devices show runaway at moderate overcharge rates, and small overcharge currents tolerated by single cells can trigger full thermal runaway when cells are arranged in series or parallel within modules.

# Over-discharge and cell reversal generate copper dissolution and dendrites that induce delayed catastrophic failure

When a weak cell in a module is driven below its safe discharge limit, copper from the current collector dissolves and later plates onto electrodes and the separator. Upon subsequent charging, lithium deposits on these copper layers because intercalation sites are obstructed, forming metallic filaments that elevate internal heating. Mild over-discharge events may appear harmless initially but can accumulate across cycles, ultimately producing internal shorts and thermal runaway. Modules are especially vulnerable because imbalance magnifies these electrochemical distortions.

# External short circuits and inadequate protection components can create rapid heating and propagate failure across packs

Low-impedance external shorts impose currents exceeding cell and module limits, causing immediate heating. While fuses or PTC devices mitigate some risks, PTCs have voltage thresholds that are easily exceeded in high-capacity systems, turning them into failure initiators through excessive charring and venting. Design flaws such as improper insulation, wire routing, or sharp edges also promote high-impedance shorts. In pouch cells, tab-burning acts as a sacrificial failure mode, but protection consistency varies by manufacturer, requiring system-level redundancy.

# Internal short circuits stem from manufacturing defects and propagate violently under high state of charge

Defects such as metal particles, holes in current collectors, and uneven coatings act as precursors for internal shorts. At full charge, simulated internal shorts show violent venting and fire. Without rigorous quality screening, defective cells can be integrated into large modules where their failure propagates across neighboring cells. Design omissions, insufficient safety controls, and field misuse can also convert overcharge, over-discharge, or external short events into internal shorts that evolve into pack-level thermal runaway.

# Temperature extremes—both high and low—drive electrochemical instability and accelerate runaway behavior

High temperatures degrade electrolyte and SEI layers, destabilize electrodes, and begin exothermic reactions that lead to venting and ignition. Low temperatures thicken the electrolyte, reduce ion mobility, and cause lithium to deposit as dendrites rather than intercalate into the anode. These deposits increase resistance and internal heating, allowing runaway even at moderate loads. Temperature gradients within a pack greater than three degrees lead to diverging aging rates and resistance shifts, increasing susceptibility to runaway across long-life ESS operation.

# Mechanical shock, vibration, and installation stresses can deform cell components and initiate internal shorts

Impact, vibration, or seismic events can distort electrode stacks, tear separators, and break tabs or interconnects. Such structural damage promotes internal shorts or localized heating. Mechanical hazards are not limited to operational life; they also occur during transport and installation of large ESS containers. Thorough inspection before and after installation is essential to ensure cells and interconnects have not been compromised.

# Effective thermal management requires uniform temperature control and active cooling to prevent runaway propagation

Large stationary batteries generate substantial heat and lack the surface area for natural convection. Air-based active cooling with controlled enclosure ventilation is the most widely used method but must avoid uneven airflow that creates hot spots. Liquid cooling offers improved performance but brings complexity and leakage risk. Thermal nonuniformity must be minimized because even small gradients accelerate divergence in resistance and capacity, increasing susceptibility to runaway. High-fidelity thermal analysis is required to identify critical monitoring points and cooling design needs.

# Aging changes voltage behavior, accelerates electrode degradation, and alters abuse response thresholds

As lithium-ion cells age, electrode delamination, electrolyte loss, and resistance rise shift how the battery responds to off-nominal conditions. Cells with more than twenty percent capacity loss generally show extensive degradation but lower likelihood of catastrophic failure, whereas cells with around seventeen percent loss may still experience dangerous responses. Aging also distorts the relationship between voltage and state of charge, requiring updated BMS algorithms and conservative charge windows to maintain long-term safety.

# Second-life use of aged batteries requires extensive assessment of degradation and thermal exposure history

Repurposed automotive batteries must be thoroughly examined before grid deployment. Modules taken from regions of highest thermal stress require destructive analysis to understand internal damage. Degradation of interconnects, cabling, and cell-to-cell interfaces influences safety as much as the cells themselves. Without detailed history and condition evaluation, aged batteries may introduce hidden imbalance or internal defect risks into large ESS configurations.

# Battery management systems must enforce per-cell monitoring, balancing, and robust fault detection to prevent hazardous deviations

A BMS must track voltage, current, and temperature at appropriate granularity to prevent single-cell drift beyond safe limits. Cell balancing mitigates divergence that leads to over-charge or over-discharge. Integration with system-level protection ensures rapid response to off-nominal signals. Remote monitoring allows operators to identify abnormal trends early and provide crucial information to first responders during incidents. Verification of BMS intervention order and reliability is essential for large ESS deployments.

# Toxic and combustible gases generated during abuse pose explosion risks in enclosed ESS containers

During thermal runaway, gases such as hydrogen, carbon monoxide, methane, ethylene, and propylene can accumulate above lower flammability limits. Immediate ignition yields small deflagrations, while delayed ignition after accumulation can produce severe explosions. Toxicity also endangers personnel entering the site post-incident. Accurately estimating gas production per cell and designing venting strategies are essential for safe installation and emergency response planning.

# Modeling and simulation support prediction of runaway propagation, gas accumulation, and explosion hazards at ESS scale

Advanced models capture heat transfer, gas generation, venting, flame behavior, and conduction pathways within cells, modules, and racks. CFD simulations help assess how gases disperse or accumulate in containerized ESS systems and inform ventilation design. Thermal network and multidimensional models support analysis of cell-to-cell propagation and the effects of vented gases. Despite challenges posed by ESS complexity and geometry, simulation is crucial for evaluating worst-case scenarios.

# Fire suppression systems face challenges with re-ignition and continued propagation in large battery arrays

Water-based suppression effectively cools cells and prevents re-ignition, especially for LFP chemistries, but can react with electrolyte salts to form toxic byproducts. Gaseous agents such as carbon dioxide and HFC compounds suffer from re-ignition issues. Dry powder and aerosol agents show chemistry-dependent effectiveness but require more system-level testing. Full-scale studies remain limited, and further research is needed to evaluate suppression performance in multi-module racks and full ESS containers.
