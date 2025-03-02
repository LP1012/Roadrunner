# Case: Tungsten
This case looks to simulate heating due to ion-beam irradiation of 2.8 MeV gold onto pure tungsten (W).
Sample thickness was taken to be 2 mm.
However, a SRIM simulation was done with 5000 Ang to achieve higher fidelty near the surface of the sample, where most of the energy is deposited.

The case in this main directory attempts to model the heat deposition for the entire sample.
As can be seen, W attenuates the Au ions very well, so an approximation as a surface heat flux is well-found to reduce the need for a highly-refined mesh.
