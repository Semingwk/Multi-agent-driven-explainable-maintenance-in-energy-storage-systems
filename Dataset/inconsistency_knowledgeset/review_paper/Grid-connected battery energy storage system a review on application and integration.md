# Grid-connected battery systems increasingly focus on application and integration rather than cell technology

Battery energy storage has moved from technology-centric research to application- and integration-centric work. Grid services such as frequency regulation, voltage support, energy arbitrage, and renewable smoothing dominate real projects. The main technical and economic concerns now lie in how BESS is allocated, controlled, and combined with other grid components, not in basic chemistry. A decade-long growth of projects shows widespread use of BESS in transmission and distribution, often tightly coupled to wind and solar generation instead of operating as standalone assets.

# Conventional classification of BESS by hardware ratings fails to capture actual battery usage

Traditional descriptions of BESS focus on business purpose, connection point, power rating, energy capacity, and location. These parameters describe hardware but not how the battery is actually cycled over years. They omit the frequency and duration of charge and discharge events, the energy processed per cycle, and the balance between active and standby time. As a result, feasibility, degradation analysis, and cross-project comparison are hampered because duty profiles cannot be reconstructed from these coarse descriptors alone.

# System-level use of state of charge and C-rate approximates energy and power but hides voltage effects

At system level, operators typically use state of charge and state of health to represent energy capability, and C-rate to represent power capability, while often neglecting cell voltage variation. When voltage differences are small or ignored, state of charge is treated as proportional to stored energy and C-rate as proportional to power per rated energy. This simplification eases control and market modeling but hides the impact of voltage-dependent behavior on effective energy, degradation, and efficiency, especially under wide state-of-charge swings or high-rate operation.

# Usage frequency quantifies how often a BESS is actively charging or discharging over its application life

Usage frequency is defined as the fraction of total application time during which the battery is actively charging or discharging rather than sitting idle. It sums all active charging and discharging periods and divides by the total elapsed time of service provision. This dimensionless parameter separates high-duty applications, where the system is nearly always moving energy, from low-duty ones that mostly remain on standby. It is applicable to short windows or the full life and directly relates to operational stress and utilization.

# Usage intensity captures how many cycles a BESS performs per unit of active operating time

Usage intensity is defined as the number of cycles, or equivalent cycles, occurring during the active usage period, normalized by the active usage time. Cycle count can be obtained via rainflow counting, energy throughput per rated energy, or integrated state-of-charge swing, provided consistent methods are used across applications. High usage intensity implies deep or frequent cycling whenever the battery is active, raising mechanical and chemical stress. Low usage intensity indicates shallow or infrequent cycling, even if the system is frequently on dispatch.

# Usage C-rate characterizes the typical charging power level during active operation

Usage C-rate averages the absolute charging C-rate over the total active charging time. It thus reflects the characteristic current or power level used while the battery is actually charging, independent of standby periods. The metric can be similarly defined for discharging but focusing on charging highlights conditions most relevant for certain degradation modes. A higher usage C-rate indicates systematically faster charging, which is linked to higher stress from lithium transport, potential plating, and thermal loads, providing a system-level bridge to cell-level current-driven aging mechanisms.

# Duty profile indicators bridge grid-level services to specific degradation causes and modes

By combining usage frequency, usage intensity, and usage C-rate, BESS duty profiles can be mapped to underlying degradation causes such as time at temperature, high state of charge, and high current. A conceptual diagram in the paper links typical grid services to mechanisms such as solid-electrolyte interphase growth, electrolyte decomposition, graphite exfoliation, and loss of electric contact. High-frequency operation at low depth of discharge stresses the system differently from rare, deep cycles at high state of charge. This mapping connects service design to expected loss of active material and capacity fade.

# Frequency control services typically show high usage frequency but low usage intensity and moderate power

Frequency regulation uses the BESS continuously to follow grid frequency deviations, yielding many short power pulses. This leads to high usage frequency because the system is almost always active, but individual energy swings tend to be shallow, keeping usage intensity modest. Response and sustaining times imposed by system operators constrain the maximum power and duration, and droop-based control shapes the state-of-charge excursions. As a result, cycle aging can be relatively limited compared with residential or arbitrage duty, even though the system is heavily dispatched.

# Power and capacity support applications impose high usage intensity through large energy swings

Load leveling, peak shaving, renewable generation curtailment reduction, and network upgrade deferral rely on BESS to move substantial energy over hours. These applications produce large state-of-charge excursions whenever they are active, so usage intensity is high even if events occur only at specific times such as peaks. They often employ high power-to-energy ratios and are constrained by network thermal limits or demand charges. Mis-sizing in these roles leads to accelerated degradation, reduced efficiency, bottleneck persistence, and poor profitability because the system is over-stressed or underutilized.

# Behind-the-meter batteries often experience frequent deep cycles due to tight sizing and local constraints

In behind-the-meter applications like residential self-consumption or commercial peak reduction, battery capacity is typically limited by space and cost. This under-sizing means local load and generation variations drive frequent deep cycles to achieve bill savings or self-sufficiency. Usage intensity is therefore high, and state-of-charge spans a wide range, exposing the cells to more extreme conditions. These systems are also heavily influenced by local tariffs, rooftop photovoltaic profiles, and user behavior, making degradation strongly dependent on site-specific dispatch and energy management strategies.

# Energy arbitrage and market services create low-frequency but high-intensity, revenue-driven cycling

Energy arbitrage and energy shifting schedules are usually designed around price forecasts or time-of-use tariffs, causing dispatch only when spreads are economically attractive. Usage frequency can be low, because operations concentrate in peak and off-peak windows, but each event may involve large energy transfers and deep state-of-charge swings, giving high usage intensity. Optimization focuses on maximizing revenue subject to technical constraints, which can push the battery into aggressive cycling patterns. Backup and black-start roles in contrast maintain high state of charge yet rarely dispatch, combining very low frequency and intensity.

# Duty profile comparison shows black start and calendar life tests as very low-usage extremes

Within the proposed usage-frequency versus usage-intensity map, black-start applications occupy a corner with low operating frequency and low cycle intensity. They require the battery to remain at high state of charge for extended periods and only deliver energy in rare contingency events, often using a small fraction of installed capacity during each occurrence. Calendar life tests represent an even more extreme case, where batteries are mostly idle except for occasional characterization cycles, emphasizing time-driven degradation such as side reactions and temperature effects rather than cycling damage.

# Hybrid and multi-storage configurations shift fast cycling away from lithium batteries to extend life

Integrated energy storage systems combine lithium batteries with supercapacitors, flywheels, superconducting machines, or other technologies. Control strategies allocate fast, shallow power fluctuations to high-power devices while reserving slower, high-energy duties for batteries. Field data from hybrid wind-storage systems show flywheels performing many equivalent cycles per day while the battery experiences very few, consistent with its role as an energy buffer. This partitioning reduces usage intensity and effective C-rate for the battery, thereby enhancing lifetime without sacrificing overall response capability or grid service quality.

# Aggregated and virtual BESS pool many small batteries and EVs into large, controllable storage resources

Aggregated battery energy storage systems combine multiple small BESS units, household batteries, or vehicle packs under a coordinated controller to mimic a single large installation. Virtual energy storage systems emphasize geographical dispersion, linking thousands of distributed PV-battery prosumers or electric vehicles. These platforms can deliver tens of megawatt-hours of flexibility for ancillary services or market participation. They enable participation from assets that individually are too small, while raising new challenges in forecasting availability, managing heterogeneous duty profiles, and distributing revenue and degradation costs among participants.

# Optimal allocation and siting of BESS must balance technical capability, economics, and lifetime

Sizing and siting studies consider load profiles, renewable penetration, network constraints, and targeted services. Methods range from analytical sizing and mathematical programming to heuristic and exhaustive search. Connection point strongly affects which services are feasible and how effectively congestion, voltage, and reliability issues are mitigated. Poor sizing can accelerate aging through excessive usage intensity, reduce efficiency, or shift bottlenecks elsewhere. Recent work highlights the need to include degradation models and project stages such as assembly, connection, operation, and maintenance when evaluating technical and business feasibility.

# Integration with renewable generators tailors BESS duty profiles to smoothing, capacity firming, and grid access

When coupled to photovoltaic or wind plants, batteries often provide power smoothing, capacity firming, and support for frequency and voltage. For PV, BESS is frequently used for distribution-level voltage control, upgrade deferral, and peak reduction, coordinated via local droop and distributed consensus controls. For wind, BESS enables automatic generation control, participation in primary and secondary frequency reserves, and service stacking with arbitrage. These roles tend to impose moderate-to-high usage intensity linked to intermittency, while energy prices and ancillary markets shape how often and how deep the battery cycles.

# Current research emphasizes SOC management and control optimization more than degradation-coupled economics

Across reviewed studies, state-of-charge management appears in most BESS applications, often using fuzzy logic, model predictive control, heuristic optimization, or stochastic scheduling. In contrast, explicit state-of-health modeling and integration of degradation into techno-economic analysis are less common and typically less mature. Many works optimize technical indicators or revenue without fully quantifying lifetime impacts. A scoring scheme in the paper shows numerous publications with high SOC and technical scores but lower SOH and economic scores, underscoring the need for better, service-specific degradation tools usable at system level.
