# Manufacturing and welding inconsistencies induce 1–2% initial parameter deviation that magnifies over time

Even in the same production batch, cells exhibit resistance and capacity deviations of 0.3% and 1.3%, respectively. Bus bar and welding inconsistencies further add up to 0.1–0.2 mΩ variation, generating unequal current paths and localized heating. This heterogeneity evolves during cycling, producing diverging voltage, current, and thermal profiles that impair SOC estimation accuracy and accelerate degradation over thousands of cycles. 

------

# 5% initial resistance and capacity variance grows to 10–25% after 310 cycles, inducing 8% SOC spread and 3°C imbalance

In a 3S3P pack, a 5% mismatch in resistance and capacity led to an 8% SOC deviation and 3°C temperature difference after a full discharge. After 310 days, these variances expanded to 10% and 25%, respectively, showing compounding propagation of heterogeneity. Such discrepancies also reduced lifetime by 40% in parallel cells with 20% mismatch, highlighting the exponential effect of small parameter variations. 

------

# Low temperatures intensify current imbalance between parallel cells with differing resistance

At 5°C, two parallel cells with a 13% resistance difference exhibited a 50% current difference, whereas at nominal temperature the deviation was smaller. The cold-induced rise in internal resistance amplifies imbalance and local overcurrent in weaker cells, accelerating degradation and skewing SOC estimation under low-temperature operation. 

------

# Cooling system asymmetry produces ≥4°C gradient and 25% current disparity, causing uneven aging

A liquid-cooled 4S pack showed a 4°C cell temperature difference and 1% voltage deviation under load. Similar gradients caused 25% current deviation and 5% faster aging per 5°C gradient. Proper thermal design maintaining ≤3°C variation across the pack is therefore crucial to minimizing SOC and resistance drift. 

------

# 20% resistance mismatch in series cells causes voltage divergence without SOC difference; in parallel cells it drives SOC imbalance

Modeling of a 3S pack with 20% resistance variance showed up to 80 mV terminal voltage spread during constant current charging, despite identical SOC. In 3P configurations, the same variance produced current redistribution and SOC imbalance during charge. Post-charge self-balancing currents equalized SOC but added energy loss and heat, showing resistance deviation primarily affects parallel branches. (Page 4, Figs. 3–4) 

------

# 10% capacity mismatch in series cells drives SOC divergence and sharp voltage spread during cycling

Simulation of a 3S pack with identical resistance but 10% capacity deviation yielded clear SOC divergence, with lower-capacity cells reaching cutoff earlier. This imbalance demands balancing intervention to prevent overcharge/overdischarge. In contrast, parallel cells showed milder SOC differences due to current redistribution. (Page 5, Figs. 5–6) 

------

# Mean cell and difference modeling reduces computation while maintaining SOC accuracy within 1–3% error

The mean-cell-plus-difference approach estimates average SOC with a high-bandwidth Kalman filter and individual deviations via simplified difference models using ΔV and ΔT. Reported root mean square error (RMSE) values are typically 0.5–3%, balancing precision and computational efficiency. It captures SOC variance due to resistance, capacity, and temperature differences without requiring full-scale estimation per cell. 

------

# Reference cell estimation provides high accuracy with medium computational load

A “reference cell” approach estimates SOC using an accurate, high-frequency estimator on the weakest cell while applying simpler filters to others. Dual time-scale EKF and nonlinear predictive filters achieved ≤2% maximum error while reducing computational effort by 50–70% compared with per-cell estimation. The method maintains robustness under temperature and resistance variations. (Table 1, page 7) 

------

# Lumped cell estimation is simplest but prone to large SOC error when cell variance exceeds 5%

Treating all cells as a single equivalent cell simplifies modeling and eliminates the need for individual monitoring. However, this method ignores heterogeneity, leading to misrepresentation of pack SOC when internal differences grow. Reported RMSE values range from 0.26% (under ideal matching) to >2.5% (with aging and variation), indicating reduced accuracy over time. 

------

# Dissipative resistive balancing is reliable but inefficient; non-dissipative methods improve speed and energy recovery

Passive balancing with switched resistors offers low cost and simplicity but wastes energy as heat and operates slowly (hundreds of mW). Active balancing using capacitors, inductors, or converters transfers energy directly between cells, achieving higher efficiency and faster equalization. However, it increases circuit complexity, size, and cost. (Fig. 13, Table 3) 

------

# Capacitor-, inductor-, and transformer-based balancing enable flexible energy transfer with different trade-offs

Switched-capacitor methods achieve modular, fast balancing but require many switches. Inductor-based designs provide high efficiency but suffer current stress. Transformer-based topologies enable isolated transfer, and converter-based (buck–boost, Cuk, or flyback) architectures allow full power flow control between cells. Overall, these active methods achieve up to 90% energy transfer efficiency but require complex control and are costlier. (Table 3, page 10) 

------

# Long-term mitigation of inconsistency requires coupling-aware estimation and thermal–electrical optimization

End-of-life packs show >10% deviation in resistance and capacity due to accumulated thermal and electrical imbalance. Robust pack SOC estimation must incorporate temperature-dependent resistance and aging effects. Mean-cell–difference models and reference-cell approaches are recommended for real-time correction. Reducing interconnect resistance and temperature gradients remains essential to limit propagation of inconsistency and maintain SOC estimation reliability. 
