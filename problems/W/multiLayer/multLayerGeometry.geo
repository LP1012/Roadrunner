// Gmsh geometry file for a multi-geometry experimental setup for ion-bebam irradiation.
// Note that all values are in METERS

// Enable OpenCASCADE kernel
SetFactory("OpenCASCADE");

// aluminum table (material may be subject to change)
aluminumHeight = 0.1;	
aluminumWidth = 1;
aluminumLength = 1;

Box(4) = {-aluminumWidth/2, -aluminumLength/2, 0, aluminumWidth, aluminumLength, aluminumHeight};

// silicon wafer
siliconRadius = 0.01;
siliconHeight = 0.01;

Cylinder(3) = {0, 0, aluminumHeight, 0, 0, siliconHeight, siliconRadius};

// carbon tape
carbonRadius = 0.01;
carbonHeight = 0.0005;

Cylinder(2) = {0, 0, aluminumHeight + siliconHeight, 0, 0, carbonHeight, carbonRadius};

// irradiated sample
sampleRadius = 0.01;
sampleHeight = 0.002;

Cylinder(1) = {0, 0, aluminumHeight + siliconHeight + carbonHeight, 0, 0, sampleHeight, sampleRadius};

// synchronize to update the geometry
// Synchronize;

// create physical groups for meshing
Physical Volume("sample") = {1};
Physical Volume("carbon_tape") = {2};
Physical Volume("silicon") = {3};
Physical Volume("table") = {4};

//+
Physical Surface("sample_top", 23) = {14};
//+
Physical Surface("carbon_top", 24) = {11};
//+
Physical Surface("sample_wall", 25) = {13};
//+
Physical Surface("carbon_wall", 26) = {10};
//+
Physical Surface("silicon_wall", 27) = {7};
//+
Physical Surface("table_top", 28) = {6};
//+
Physical Surface("silicon_top", 29) = {8};
//+
Physical Surface("table_wall", 30) = {4, 1, 3, 2};
//+
Physical Surface("table_bottom", 31) = {5};
