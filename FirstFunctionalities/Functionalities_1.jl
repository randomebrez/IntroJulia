# ============== Base types =============
# variable definition is similar to  python 
x = 5
str = "My string" 

# we can write variable with greek alphabet using lateX notation "\delta"+tab
#(tab autocomplete to transform into the greek letter, it seems it doesn't work if you don't tab)
δ = 0.1

# We can chain definitions
a = b = 3
c = (d = 2 + 5) * 2

println("a = $a") 
println("b = $b")
println("c = $c")
println("d = $d")

# Complex numbers using 'im'
complex_1 = 5 + 3im
complex_2 = a + b*im # '*' is necessary here to not interpret as a variable named 'bim'
complex_3 = Base.complex(a, b) # or using the 'complex' function from 'Base' module
println("complex_1 : $complex_1")
println("complex_2 : $complex_2")
println("complex_3 : $complex_3")

# ==============Array===============
println("\n ==============Array=============== \n")
l1 = [1, 2, 3, 4] # /!\ Indexation starts at 1. Quelle indignité...

print("First element of l1: ")
println(l1[1]) # println is used to print with a line break at the end

print("Last element of l1 : ")
println(l1[end]) # /!\ l1[-1] doesn't work to access the last element

print("Second element of l1 using begin : ")
println(l1[begin + 1]) # we can also use l1[begin] to access first element. 'begin' returns an integer, so we can use operators as '+'

l2 = l1 # Both variables refers to the same array (as in Pyhton)
l1[1] = 25
println("l1 : $l1") # '$' inside a string is used to interpolate
println("l2 : $l2\n")

# Another way equivalent to np.linspace or np.arange
l3 = 1:10 # default step size of 1
l4 = 1:0.5:5 # step size of 0.5

println("l3 : $l3")
println("l4 : $l4\n")

# The prints are not very satisfying, but it is a collection as we can see
println("Type of l3 : $(typeof(l3))")
for i in l4
    println("l4 : $i")
end # note that 'end' is necessary here, while in python we would just removed the indentation

# And we can store it as a proper array using 'collect'
l5 = collect(l3)
println("\nType of l5 : $(typeof(l5))")
println(l5)

# To build arrays we can also use 
zeros_array = zeros(3,4)
println("\n3*4 zero array : $zeros_array")

value_array = fill(25, 3, 4)
println("3*4 array filled with 25 : $value_array")

random_array = rand(3,4)
println("3*4 random array : $random_array")

# ==============Chains===============
println("\n ==============Chains=============== \n")
# Comparison operators are the same as in every language BUT we can chain them !
is_it = 1 < 2 <= 2 < 3 == 3 > 2 != 5
println("is_it : $is_it")

# we can chain instructions on a single line using ';'
y = 3; println(1 + y^2 * 3)

# ==============Code blocks===============
println("\n ==============Code blocks=============== \n")
# No difficulty here, just a syntaxic introduction to for/while/if/begin ...
# Code blocks are delimited by 'keyword' {...} 'end'
# Most of them define a local variable scope and can access global/parent variable scope. Once out, variables are destroyed
# There is an exception for the 'if' block that allows to define variables that will survive in the encapsulating block. The condition for that is that
# every possible code path of the 'if' block assign a value to that variable.
for x in eachindex(l1)
    println("x value within the for loop : $x") # note that 'x' is not equal to 5 as we defined on first line. It is a local variable that shadows the global variable
    if l1[x] > 5
        leaky_if_block = "greater than 5" # For example replace that line by 'continue' (that will just skip the loop iteration) and an error will be raised
    elseif l1[x] < 3
        leaky_if_block = "smaller than 3"
    else
        leaky_if_block = "It is between 3 and 5"
    end # 'end' to close if/elseif/else block
    println("Variable define within if block : $leaky_if_block")
end # 'end' to close 'for' loop

println("\nx value outside the for loop : $x")
try
    println("Variable define within if block : $leaky_if_block")
catch
    println("Variable 'leaky_if_block' doesn't exist anymore")
end

# We can define temporary variable, that we use to compute others but don't want to keep in memory
complex_variable = let
    intermediate_calculus = π
    other_intermediate_calculus = 10
    intermediate_calculus * other_intermediate_calculus # Julia will assign the last line of a code block to the variable 'complex_variable'
end

println("\nComplex variable : $complex_variable")
try
    println("Intermediate variables : $intermediate_calculus")
catch
    println("Variable 'intermediate_calculus' doesn't exist anymore")
end

# by default Julia print (and return) the last line of a block of code (here the entire file)
last_print = "This is the last line"