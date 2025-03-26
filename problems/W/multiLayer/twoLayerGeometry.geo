// Gmsh geometry file for a multi-geometry experimental setup for ion-bebam irradiation.
// Note that all values are in METERS

// Enable OpenCASCADE kernel
SetFactory("OpenCASCADE");


// carbon tape
carbonRadius = 0.01;
carbonHeight = 0.0005;

Cylinder(2) = {0, 0, 0, 0, 0, carbonHeight, carbonRadius};

// irradiated sample
sampleRadius = 0.01;
sampleHeight = 0.002;

Cylinder(1) = {0, 0, carbonHeight, 0, 0, sampleHeight, sampleRadius};

// synchronize to update the geometry
// Synchronize;

// create physical groups for meshing
Physical Volume("sample") = {1};
Physical Volume("carbon_tape") = {2};
//+
Physical Surface("sample_top", 7) = {5};
//+
Physical Surface("sample_wall", 8) = {4};
//+
Physical Surface("carbon_wall", 9) = {1};
//+
Physical Surface("carbon_bottom", 10) = {3};
//+
Physical Surface("carbon_top", 11) = {2};

// Mesh settings
Mesh.ElementOrder = 2;  // Set element order: 1 for linear, 2 for quadratic
Mesh.Algorithm = 1;     // Meshing algorithm: 1 = Delaunay, 2 = Frontal, 3 = Advancing Front
Mesh.Optimize = 1;      // Optimize mesh quality
Mesh.Smoothing = 5;     // Smooth mesh with (int) steps

// Set mesh size globally or on individual geometries
Mesh.MeshSizeFactor = 1;   // This will get small in a hurry


// Generate 3D mesh
Mesh 3;

