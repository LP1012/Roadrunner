# NOT FINISHED -- NEED TO FINISH IMPLEMENTING THE PIECEWISE LINEAR FUNCTION TO THE HEATING TERM
# AFTER THIS, MOVE ON TO TIME DEPENDENCE

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
    [heat_source]
        type = HeatSource
        variable = u
        function = SRIM_heating
        # value = 1e10
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

        # type = DirichletBC
        # boundary = top
        # variable = u
        # value = 350
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

        # type = NeumannBC
        # boundary = bottom
        # value = 0 
        # variable = u
    []
[]

[Functions]
    [SRIM_heating]
        type = PiecewiseLinear
        data_file = test_mooseHEATING_phi=1.000e+08.csv
        scale_factor = 1e4
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