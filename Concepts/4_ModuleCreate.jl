# A module in Julia defines a namespace. It is delimited by 'module' {...} 'end'. It is the equivalent of namespaces in C
# Here we define a simple module that builds n-dimensionnal world and instantiate units into it
# that can random walk. if units cross a world boundary, they are transferred on the other side (tore map)
module MiniWorld

# >>> Import external modules region <<<
using Random

unit_id_counter = 0 # global variable

# A structure is a container. It defines a custom type
struct Unit
    id::Int64
    step_size::Int64
    position::Vector{Int64}
end

struct World
    dimensions::Vector{Int64}
    units::Vector{Unit}
end

# >>> Functions definition region <<<

# ============== World & unit initialization ==============
function InitializeWorld(dimensions::Vector{Int64}, unit_number::Int64)
    world = World(dimensions, Vector{Unit}(undef, unit_number)) # the 'undef' keyword in the Vector constructor tell the compiler than values of the array is not yet defined
    for i in 1:unit_number
        world.units[i] = InitializeUnit(dimensions)
    end
    ReplaceOutOfBoundsUnits(world)
    return world
end

function InitializeUnit(world_dimension::Vector{Int64})
    initial_position = world_dimension .|> single_dimension -> rand(0:single_dimension)
    step_size = rand(1:3)
    global unit_id_counter += 1 # variables in a function are defined in the scope of the function and shadows outer scope variable with the same name.
    # The 'global' keyword avoid this shadowing, and the variable is the one defined l.9
    return Unit(unit_id_counter - 1, step_size, initial_position)
end

# ============== World update ==============

function IncreaseTimeStep(world::World)
    RandomWalk.(world.units)
    ReplaceOutOfBoundsUnits(world)
end

# ============== Tools ==============
function RandomWalk(unit::Unit)
    displacements = rand(-1:1, length(unit.position))
    unit.position .+= unit.step_size * displacements
end

# This method checks for each unit, if each of its coordinate is within the world, and update them if needed
function ReplaceOutOfBoundsUnits(world::World)
    @. world.units |> unit -> unit.position = CheckUnitCoordinate(unit.position, world.dimensions)
end

# This method checks if a given coordinate is out of the world limits.
# If yes, it returns the new position within the world (considering the world as a tore)
function CheckUnitCoordinate(coordinate::Int64, world_size)
    max_coordinate = world_size / 2
    if coordinate < -max_coordinate
        return coordinate + world_size
    elseif coordinate > max_coordinate
        return coordinate - world_size
    else
        return coordinate
    end
end

function PrintUnit(unit::Unit)
    println("$(unit.id) : $(unit.position)")
end

end
