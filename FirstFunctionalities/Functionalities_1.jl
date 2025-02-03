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
end

# And we can store it as a proper array using 'collect'
l5 = collect(l3)
println("\nType of l5 : $(typeof(l5))")
println(l5)

println("\n ==============Chains=============== \n")
# Comparison operators are the same as in every language BUT we can chain them !
is_it = 1 < 2 <= 2 < 3 == 3 > 2 != 5
println("is_it : $is_it")

# we can chain instructions on a single line using ';'
y = 3; println(1 + y^2 * 3)

# by default Julia print the last line of a block of code
last_print = "This is the last line" 