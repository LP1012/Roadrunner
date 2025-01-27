// Gmsh project created on Sun Jan 26 23:59:00 2025
SetFactory("OpenCASCADE");
//+
Rectangle(1) = {0, 0, 0, 0.000002, 0.0000005, 0};
//+
Physical Curve("top", 5) = {3};
//+
Physical Curve("bottom", 6) = {1};
//+
Physical Curve("wall", 7) = {4, 2};
//+
Physical Surface("sample_surface", 8) = {1};
