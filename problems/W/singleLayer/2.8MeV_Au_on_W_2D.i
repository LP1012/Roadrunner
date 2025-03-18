# This input file is specifically looking at the approximation that all of the gold ions' energy
# is depositied on the surface (that is, the SRIM data is integrated and approximated as a surface
# flux)

[Mesh]
    type = FileMesh
    file = '../../meshes/2D_0.04.msh'
[]

[Variables]
    [u]
        # Values in Kelvin
        order = first 
        family = Lagrange
        initial_condition = 250
    []
[]

[Kernels]
    [heat_conduction]
        type = HeatConduction
        variable = u
    []
        
[]

[Materials]
  [thermal]
    type = HeatConductionMaterial
    thermal_conductivity = 173  # W/m-K
  []
[]

[BCs]
    [top]
        type = NeumannBC
        boundary = top
        value = 64271
        variable = u
    []
    [wall]
        type = NeumannBC
        boundary = wall
        variable = u
        value = 0
        
    []
    [bottom]
        type = DirichletBC
        value = 300
        boundary = bottom
        variable = u
    []
    # [bottom]
    #     type = NeumannBC
    #     boundary = bottom
    #     variable = u
    #     value = -1e6
    # []
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
