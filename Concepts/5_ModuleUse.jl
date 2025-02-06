# Here we will use our module MiniWorld

# First we need to load the module
include("4_ModuleCreate.jl")

# Then import it in the current file either with 'using' or 'import'.
# 'import' let you rename the module with 'as', so I will use it here
# Note the '.' before the module name. It is necessary because the module is a local one
import .MiniWorld as mw

# World initialization (any number of dimension is acceptable)
world_dimensions = [12, 8, 6]
unit_number = 4
world = mw.InitializeWorld(world_dimensions, unit_number)


time_step_number = 10

# Run the "simulation"
for i in 1:time_step_number
    mw.IncreaseTimeStep(world)
end

# print final positions
for unit in world.units
    mw.PrintUnit(unit)
end

println("\n")

# Or with a more julia style using pipe and '.' vectorization
1:time_step_number .|> ts -> mw.IncreaseTimeStep(world)
mw.PrintUnit.(world.units)

println("\n")
