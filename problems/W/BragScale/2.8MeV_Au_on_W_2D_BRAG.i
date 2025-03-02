# NOT FINISHED -- NEED TO FINISH IMPLEMENTING THE PIECEWISE LINEAR FUNCTION TO THE HEATING TERM
# AFTER THIS, MOVE ON TO TIME DEPENDENCE

[Mesh]
    type = FileMesh
    file = '../../../meshes/W_BragMatch2.msh'
[]

[Variables]
    [u]
        # Values in Kelvin
        order = second 
        family = Lagrange
        initial_condition = 250
    []
[]

[Kernels]
    [heat_conduction]
        type = HeatConduction
        variable = u
    []
    [heat_source]
        type = HeatSource
        variable = u
        function = SRIM_heating
    []
        
[]

[Materials]
  [thermal]
    type = HeatConductionMaterial
    thermal_conductivity = 175
  []
[]

[BCs]
    [top]
        type = NeumannBC
        boundary = top
        value = 0
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
        boundary = bottom
        value = 300
        variable = u
    []
[]

[Functions]
    [SRIM_heating]
        type = PiecewiseLinear
        data_file = test_mooseHEATING_phi=1.000e+13.csv
        scale_factor = 1e5
        axis = y
    []
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