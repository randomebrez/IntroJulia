# Here we introduce the notion of module that helps organizing the code into coherent sections
# Modules define variables, structures (struc) and functions that can are designed to be used by someone else
# (or by another part of the code) but not as a standalone

module Functions

function EuclidianDistance(x, y)
    return sqrt(x^2 + y^2)
end

function EuclidianDistanceWithoutReturn(x, y)
    sqrt(x^2 + y^2)
end

EuclidianDistanceCompact(x, y) = sqrt(x^2 + y^2)

end