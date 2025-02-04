# Julia relies on the use of Modules that are loaded (precompiled) with the 'using' keyword
# There is standard library that includes usefull tools such as 'LinearAlgebra', 'Random', 'Statistics'

using LinearAlgebra, Random, Statistics # Standard library modules

A = [1 2 3; 4 1 6; 7 8 1]
B = 2*A
println("Matrix A : $A")
println("Matrix B : $B\n")

# ==============LinearAlgebra basic operations==============
println("\n==============LinearAlgebra basic operations==============\n")
trace_A = tr(A)
det_A = det(A)
inv_A = inv(A)
matrix_product = A*B
println("Trace of A : $trace_A")
println("Determinant of A : $det_A")
println("Inverse of A : $inv_A")
println("Matrix product A*B = $matrix_product")

# ==============LinearAlgebra more evolved operations==============
println("\n==============LinearAlgebra more evolved operations==============\n")
eigen_values = eigvals(A)
eigen_vec = eigvecs(A)
lu_factorize = factorize(A)
println("Eigen values of A : $eigen_values")
println("Eigen vectors of A : $eigen_vec")
println("L part of the factorization of A : $(lu_factorize.L)")
println("U part of the factorization of A : $(lu_factorize.U)")

# ==============Random module==============
println("\n==============Random module==============\n")

# By default we draw in the [0, 1) subset
uniform_vec = rand(5)
println("uniform vector in [0, 1) : $uniform_vec")

# We can specify the set in which we draw
uniform_vec_from_a_subset =  rand(1:9, 5)
println("uniform vector between 1 & 9 : $uniform_vec_from_a_subset\n")

# That can also be a string 
uniform_vec_string = rand("ACTG", 10)
println("uniform vector of string : $uniform_vec_string")

# And that can also return a string
uniform_string = randstring("ACTG", 10)
println("uniform string : $uniform_string\n")

# Other distribution are implemented
exp_vec = randexp(5)
println("exponential distribution : $exp_vec\n")

# When a julia session is strated, the RNG is seeded with a random seeded. We can force a seed to ensure reproductibility using 'Random.seed!()'
# 
# Here we have to qualify the function call (prefix it with the module name) because the seed function is not a 'public' function of the Module.
# Without enterring into too much details, when loading a module, you get access to all 'public' (exported) functions/field/structures ... that are specified
# by the module author, and are supposed to be the general way of using that module.
# Nevertheless, non exported fields can still be accessed by qualifying the function call because Julia don't provide 'private' qualifiers as in C for example.
Random.seed!(5) 
seeded_vec = rand(2)
println("Seeded vector : $seeded_vec")

another_vec = rand(2)
println("Different random vector : $another_vec")

Random.seed!(5)
seeded_vec_2 = rand(2)
println("Same vector as first generated : $seeded_vec_2")

another_vec_2 = rand(2)
println("Same vector as second generated : $another_vec_2\n")

# ==============Statistics module==============
println("\n==============Random module==============\n")
uniform_std = std(uniform_vec)
println("Standard deviation : $uniform_std")

uniform_mean = mean(uniform_vec)
println("Mean : $uniform_mean")

uniform_var = var(uniform_vec)
println("Variance : $uniform_var")

pearson_correlation_along_row = cor(A, B)
println("Pearson correlation matrix of A&B: $pearson_correlation_along_row")

covariance_matrix = cov(A,B)
println("Covariance matrix of A&B: $covariance_matrix")