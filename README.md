# ESN - Echo State Network

A Rust implementation of Echo State Networks (reservoir computing) for time series prediction and classification.

## Features

- Sparse randomly connected reservoir
- Leaky integrator neurons
- Multiple activation functions (Tanh, Sigmoid, ReLU, LeakyReLU)
- Linear readout with ridge regression training
- Optional feedback connections
- Hierarchical ESN (multiple stacked reservoirs)
- State history for context

## Installation

```toml
[dependencies]
esn = "0.1"
```

## Quick Start

```rust
use esn::{EchoStateNetwork, EsnConfig, Activation};
use ndarray::Array1;

// Create an ESN with 500 neurons
let config = EsnConfig {
    reservoir_size: 500,
    spectral_radius: 0.95,
    leaking_rate: 0.3,
    input_scale: 0.5,
    ..Default::default()
};

let mut esn = EchoStateNetwork::new(config, 10, Activation::Tanh)?;

// Process input
let input = Array1::from_vec(vec![0.5; 10]);
let state = esn.step(&input);

// Train on data (after collecting states)
let mse = esn.train(&inputs, &targets, washout)?;

// Predict
let output = esn.predict()?;
```

## Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `reservoir_size` | 500 | Number of reservoir neurons |
| `spectral_radius` | 0.95 | Controls memory/stability tradeoff |
| `leaking_rate` | 0.3 | Neuron update rate (0-1) |
| `input_scale` | 0.5 | Input weight scaling |
| `sparsity` | 0.9 | Reservoir connectivity (higher = sparser) |
| `ridge_param` | 1e-6 | Ridge regression regularization |

## Hierarchical ESN

Stack multiple reservoirs for complex temporal patterns:

```rust
use esn::{HierarchicalEsn, EsnConfig, Activation};

let configs = vec![
    EsnConfig { reservoir_size: 100, ..Default::default() },
    EsnConfig { reservoir_size: 50, ..Default::default() },
];

let mut h_esn = HierarchicalEsn::new(
    configs,
    input_dim,
    vec![Activation::Tanh, Activation::Tanh]
)?;

let output = h_esn.step(&input);
let combined = h_esn.get_combined_state(); // All layer states
```

## Use Cases

- Time series prediction
- Sensor data processing
- Speech recognition
- Anomaly detection
- Chaotic system modeling

## References

- Jaeger, H. (2001). "The echo state approach to analysing and training recurrent neural networks"
- Lukoševičius, M. (2012). "A practical guide to applying echo state networks"

## License

MIT License
