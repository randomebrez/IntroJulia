using .Functions

x = 2
y = -1

euclidian_distance = EuclidianDistance(x, y)
println("V1 : $euclidian_distance")

euclidian_distance_without_return = EuclidianDistanceWithoutReturn(x, y)
println("WithoutReturn : $euclidian_distance_without_return")

euclidian_distance_compact = EuclidianDistanceCompact(x, y)
println("WithoutReturn : $euclidian_distance_compact")