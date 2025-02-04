x = 1; y = -2
float_x = 1.0; float_y = -5.1
string_x = "x"; string_y = "y"
array_x = collect(0:2:8); array_y = collect(1:2:9)

# ==============Different ways of defining functions===============
println("\n ==============Different ways of defining functions=============== \n")

# The usual way to define a function is by using the "'function' {...} 'end'" block
function EuclidianDistance(x, y)
    return sqrt(x^2 + y^2)
end

# return is optionnal since Julia returns the last line of a block by default
function EuclidianDistanceWithoutReturn(x, y)
    temp = x^2 + y^2 # won't be returned
    sqrt(temp) # last line is returned
end

# For short function, "=" symbol can be used for a one-line definition
EuclidianDistanceCompact(x, y) = sqrt(x^2 + y^2)

euclidian_distance_v1 = EuclidianDistance(x, y)
euclidian_distance_v2 = EuclidianDistanceWithoutReturn(x, y)
euclidian_distance_v3 = EuclidianDistanceCompact(x, y)

println("V1 : $euclidian_distance_v1")
println("V2 : $euclidian_distance_v2")
println("V3 : $euclidian_distance_v3")

# ==============Specialization - Multiple dispatch===============
println("\n ==============Specialization - Multiple dispatch=============== \n")
# In the above functions, argument type were not declared (as in dynamic languages like Python)
# We can declare argument type, function return type (and every variable we define) using '::'
# Type declaration is usefull for :
#   - Code clarity
#   - Specialization of functions for specific types (requiring a different implementation)
#   - Ensure your code is not messing around with unexpected arguments
#   - Benefit from compiler optimization for specific types (for example multiplying 'float' is less computationnally efficient than multiplying 'int')
# ==> It allows to benefit from Julia's multiple dispatch, that is a key argument for the use of Julia. It lets the program decide which function
# to use depending on the argument(s) type provided at run time, for better efficiency

# Here is a base example with multiplication
# First just define the function without type declaration
Multiply(x, y) = x * y

expected_int = Multiply(x, y)
expected_float = Multiply(float_x, float_y)
ah_ouais = Multiply(string_x, string_y)

println("Using int : $x * $y = $expected_int")
println("Using float : $float_x * $float_y = $expected_float")
println("Using string : $string_x * $string_y = $ah_ouais\n")

# To avoid those unexpected surprises, and ensure our code is doing exactly what we want it to do
# We can declare type (for argument and return type) what is called specialization of a function
# When calling the function, the compiler will automatically call the right one regarding argument types
Multiply_specialized(x::Int64, y::Int64)::Int64 = x * y
Multiply_specialized(x::Float64, y::Float64)::Float64 = x * y

# same method called
specialized_int = Multiply_specialized(x, y)
specialized_float = Multiply_specialized(float_x, float_y)

println("$x * $y = $specialized_int")
println("$float_x * $float_y = $specialized_float")

# Resulting in a error if we don't provide the right type (here 'string')
try
    error_with_strings = Multiply_specialized(string_x, string_y)
    println("Everything is fine !") # won't be printed
catch error
    println("Error caught !")
end

# And we can change the implementation for other types
function Multiply_specialized(x::Array, y::Array)
    smaller_size = min(length(x), length(y))
    result = zeros(smaller_size)
    for i in 1:smaller_size
        result[i] = x[i] * y[i]
    end    
    return result     
end

specialized_array = Multiply_specialized(array_x, array_y)
println("Array multiplication : $specialized_array\n")

# ==============Anonymous functions===============
println("\n ==============Anonymous functions=============== \n")
# Another way of defining small functions is the anonymous declaration using '->' notation
# It is usefull for functions that take other function as input.
# For example the 'map' function, that ... maps a function on each element of a collection
values_with_anonymous_function = map(anonymous -> 4 * anonymous, array_y)
println("Anonymous function : $values_with_anonymous_function")

# If the function to pass as argument is more complex, we can use the 'do' block syntax, that will create an anonymous function
# and pass it as the first argument of the method called
# For example if we want to apply Syracuse iteration on an array :
new_range = 1:20
next_iteration =  map(x -> begin
        if x == 1
            return x 
        elseif x % 2 == 0
            return x / 2
        else
            return 3 * x + 1
        end
    end, new_range)
println("Next iteration : $next_iteration")

next_iteration_with_do = map(new_range) do x 
    if x == 1
        return x 
    elseif x % 2 == 0
        return x / 2
    else
        return 3 * x + 1
    end
end
println("Next iteration using do syntax : $next_iteration_with_do\n")


# ==============Function vectorization===============
println("\n ==============Function vectorization=============== \n")

# Another extremly cool feature of Julia is the automatic vectorization of methods
# Let's define a gaussian function (using greek letters because we can !)
gauss(x, μ, σ) = exp(-(x - μ)^2 / σ)

# we can of course compute it for a 'int'
int_gauss = gauss(x, 0, 1)
println("Gauss($x, 1, 0) = $int_gauss")

# And there is no effort to vectorize it. Simply add '.' after your function call
array_gauss = gauss.(array_x, 0, 1)
println("Gauss($array_x, 0, 1) = $array_gauss")

# Using 2 array in the method call will result in an element-wise operation
element_wise = gauss.(array_x, array_y, 1)
println("Element wise Gauss : $element_wise")

# This '.' notation is a general rule. Therefore we can write
# Note that for unary or binary operators the '.' is on the left of the operator
sum_result = 10 .+ array_x
println(sum_result)

# We can also chain those definitions
chained_dot_syntax = gauss.(cos.(array_x).^2 .+ sin.(array_x).^2, 0, 1)
println("Chained dot syntax : $chained_dot_syntax")

# This notation can become messy with a long chain
# There exist the macro annotation using '@.' to invoke all functions as vectorized: 
macro_syntax = @. gauss(cos(array_x)^2 + sin(array_x)^2, 0, 1)
println("Macro syntax : $macro_syntax")


# ==============Piping===============
println("\n ==============Piping=============== \n")
# There is a last notation that can be usefull that is the pipe '|>' allowing to transfer the output of a function/calculus
# as an input for the next operation
x |> anonymous_gauss -> gauss(anonymous_gauss, 0, 1) |> anonymous_print -> println("Print using an int : $anonymous_print") # using a single value
array_x |> anonymous_gauss -> gauss.(anonymous_gauss, 0, 1) |> anonymous_print -> println("Print using an array : $anonymous_print") # using an array
# And we can combine '.' with '|>' and the possibilities are infinite.
# Note that in this last version there is a 'print' element-wise since the gauss method returns elements one by one
array_x .|> anonymous_gauss -> gauss(anonymous_gauss, 0, 1) |> anonymous_print -> println("Print using combined dot&pipe : $anonymous_print")

x # just to avoid the print & return of the last line