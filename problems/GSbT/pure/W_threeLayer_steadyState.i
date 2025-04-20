# This input file is specifically looking at the approximation that all of the gold ions' energy
# is depositied on the surface (that is, the SRIM data is integrated and approximated as a surface
# flux)

# This input file takes a slightly-simplified geometry that only has three bodies and attempts to model
# the heat conduction across them. Steady-state is specified as a base case.

[Mesh]
  type = FileMesh
  file = 'threeLayerMesh.e'

  block_id = '1 2 3' # these come from the .geo file made with Gmsh
  block_name = 'sample carbon_tape silicon' # can be arbitrarily selected

    
[]

[Variables]
    [u]
        # Values in Kelvin
        order = FIRST 
        family = Lagrange
        initial_condition = 300
    []
[]

[Kernels]
    [heat_conduction]
        type = HeatConduction
        variable = u
    []

[]

[Materials]
  # [tungsten]
  #   type = GenericConstantMaterial
  #   prop_names =  'thermal_conductivity   specific_heat   density'
  #   prop_values = '173                    134             19300'
  #   block = sample
  # []

  # [carbon_tape]
  #   type = GenericConstantMaterial
  #   prop_names =  'thermal_conductivity   specific_heat   density'
  #   prop_values = '15                     710             22000'
  #   block = carbon_tape
  # []

  # [silicon]
  #   type = GenericConstantMaterial
  #   prop_names =  'thermal_conductivity   specific_heat   density'
  #   prop_values = '148                    705             2330'
  #   block = silicon
  # []


  [tungsten]
    type = HeatConductionMaterial
    block = sample 
    temp = u
    specific_heat_temperature_function = W_cp
    thermal_conductivity_temperature_function = W_thermCond
  []
  [tungsten_density]
    type = ParsedMaterial
    block = sample
    expression = 19300+0.0001*u  # dummy expression
    coupled_variables = u
    property_name = 'density'
  []

  [carbon_tape]
    type = HeatConductionMaterial
    block = carbon_tape
    temp = u
    specific_heat_temperature_function = carbonTape_cp
    thermal_conductivity_temperature_function = carbonTape_thermCond
  []
  [carbonTape_density]
    type = ConstantMaterial
    property_name = 'density'
    value = 22000
    block = carbon_tape
  []

  [silicon]
    type = HeatConductionMaterial
    block = silicon
    temp = u
    specific_heat_temperature_function = Si_cp
    thermal_conductivity_temperature_function = Si_thermCond
  []
  [silicon_density]
    type = ConstantMaterial
    property_name = 'density' 
    value = 2230
    block = silicon
  []
    
[]

[Functions]
  [W_thermCond]
    type = ParsedFunction
    expression = 173+0.0001*t  # dummy values
  []
  [W_cp]
    type = ParsedFunction
    expression = 134+0.0001*t  # dummy values
  []
  [carbonTape_thermCond]
    type = ConstantFunction
    value = 15
  []
  [carbonTape_cp]
    type = ConstantFunction
    value = 710
  []
  [Si_thermCond]
    type = ConstantFunction
    value = 148
  []
  [Si_cp]
    type = ConstantFunction
    value = 705
  []

[]

[BCs]
    [sample_top]
        type = NeumannBC
        boundary = sample_top
        value = 321.411
        
        variable = u
    []
    
    [walls]
        type = NeumannBC
        boundary = walls
        variable = u
        value = 0
    []
    [silicon_bottom]
        type = DirichletBC
        value = 300
        boundary = silicon_bottom
        variable = u
    []
    [sample-carbon_interface]
        type = HeatConductionBC
        boundary = sample-carbon_interface
        variable = u
    []
    [carbon-silicon_interface]
      type = HeatConductionBC
      boundary = carbon-silicon_interface
      variable = u
  []
[]



[Executioner]
  type = Steady
  solve_type = NEWTON
  
  # # Set PETSc parameters to optimize solver efficiency
  petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
  petsc_options_value = ' hypre    boomeramg'



  # USE THIS FOR DEBUGGING
  # petsc_options = '-pc_svd_monitor'
  # petsc_options_iname = '-pc_type'
  # petsc_options_value = 'svd'
[]

[Outputs]
  exodus = true
[]
