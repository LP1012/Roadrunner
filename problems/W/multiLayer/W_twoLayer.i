# This input file is specifically looking at the approximation that all of the gold ions' energy
# is depositied on the surface (that is, the SRIM data is integrated and approximated as a surface
# flux)

# This input file takes a slightly-simplified geometry that only has two bodies and attempts to model
# the heat conduction across them. Once this has been accomplished, a different input file will be created.

[Mesh]
    type = FileMesh
    file = 'twoLayerMesh.msh'

    block_id = '1 2' # these come from the .geo file made with Gmsh
    block_name = 'sample carbon_tape' # can be arbitrarily selected
[]

[Variables]
    [u]
        # Values in Kelvin
        order = second 
        family = Lagrange
        initial_condition = 350
    []
[]

[Kernels]
    [heat_conduction]
        type = HeatConduction
        variable = u
    []
        
[]

[Materials]
  [tungsten]
    type = HeatConductionMaterial
    thermal_conductivity = 173  # W/m-K
    block = 'sample'
  []
  [carbon_tape]
    type = HeatConductionMaterial
    thermal_conductivity = 15  # W/m-K
    block = 'carbon_tape'
  []
[]

[BCs]
    [sample_top]
        type = NeumannBC
        boundary = sample_top
        value = 32141
        variable = u
    []
    [sample_wall]
        type = NeumannBC
        boundary = sample_wall
        variable = u
        value = 0
    []
    [carbon_wall]
        type = NeumannBC
        boundary = carbon_wall
        value = 0
        variable = u
    []
    [carbon_bottom]
        type = DirichletBC
        value = 300
        boundary = carbon_bottom
        variable = u
    []
    [material_interface]
        type = HeatConductionBC
        boundary = carbon_top
        variable = u
    []
[]

[Functions]
    # [SRIM_heating]
    #     type = PiecewiseLinear
    #     data_file = test_mooseHEATING_phi=1.000e+08.csv
    #     scale_factor = 1e4
    # []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  
  # Set PETSc parameters to optimize solver efficiency
  petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
  petsc_options_value = ' hypre    boomeramg'
[]

[Outputs]
  exodus = true
[]
