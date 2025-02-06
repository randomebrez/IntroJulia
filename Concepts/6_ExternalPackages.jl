# External packages can be loaded using the 'Pkg' module (that is included in the standard library)
using Pkg
# The 'add' method will install in the environment the package with all dependencies
# There is a command at the end of the file to remove it to not pollute your PC !

Pkg.add("GLMakie") # Library to make graphics using OpenGL

# In the REPL you can type ']' wich will change your prompt to "pkg>" that is the Julia package manager
# then type 'add "GLMakie"' to add the package to your environment.

# Once added we need to import it in the current file with 'using'
using GLMakie

# Define a gaussian function
gauss(x, μ, σ) = exp(-(x - μ)^2 / σ)

# Define a tool function that returns a range -length/2:length/2
function AxisZeroCentered(length)
    negative_limit = length ÷ 2 # '\div' + tab : division entiere
    positive_limit = iseven(length) ? negative_limit - 1 : negative_limit
    return -negative_limit:positive_limit
end

# Function that compute the norm of the each point of a (discretized) plan
function distmap(sz::NTuple{2,Int})
    height, width = sz
    [sqrt(x^2 + y^2) for y in AxisZeroCentered(height), x in AxisZeroCentered(width)]
end

# Specialized it to compute the norm of each point of a volume
function distmap(sz::NTuple{3,Int})
    height, width, depth = sz
    [sqrt(x^2 + y^2 + z^2) for y in AxisZeroCentered(height), x in AxisZeroCentered(width), z in AxisZeroCentered(depth)]
end

# Magical tool. '...' is used to provide a variable argument number and convert them into a tuple
distmap(d...) = distmap(d)


# =====================Interesting functions ======================

#Function that draws a simple plot
function SimplePlot(max_x)
    points = -max_x:0.1:max_x
    plot(points, gauss.(points, 0, 1)) |> display
    # you can replace 'plot' by 'line' to get a line
end


# A bit more complex with sliders, making the plot interactive !
function SimplePlotWithSliders(max_x)
    points = -max_x:0.1:max_x
    fig = Figure()
    ax = Axis(fig[1, 1])

    # Define sliders
    sgrid = SliderGrid(
        fig[2, 1],
        (label = "mu", range = -5:0.5:5, startvalue=0),
        (label = "sigma", range = 0.5:0.5:10, startvalue=0))
    
    # get them as variables
    sl_mu, sl_sigma = sgrid.sliders
    
    # Compute the points to plot using the sliders value
    gaussian_values = lift(sl_mu.value, sl_sigma.value) do mu, sigma
        gauss.(points, mu, sigma)
    end

    # Draw the plot
    lines!(ax, points, gaussian_values)
    fig
end

# This is the epic boss at the end
function BeautifulCube()
    x, y, z = 1:64, 1:64, 1:64
    vol = distmap(64, 64, 64)

    fig = Figure()
    ax = LScene(fig[1, 1], show_axis = false)

    plt = volumeslices!(ax, x, y, z, vol, colormap = :thermal)

    sgrid = SliderGrid(
        fig[2, 1],
        (label = "yz plane - x axis", range = x),
        (label = "xz plane - y axis", range = y),
        (label = "xy plane - z axis", range = z),
    )

    # connect sliders to `volumeslices` update methods
    sl_yz, sl_xz, sl_xy = sgrid.sliders
    on(v -> plt[:update_yz][](v), sl_yz.value)
    on(v -> plt[:update_xz][](v), sl_xz.value)
    on(v -> plt[:update_xy][](v), sl_xy.value)

    display(fig)
end


SimplePlot(10)
# SimplePlotWithSliders(10)
# BeautifulCube()

# Pkg.remove("GLMakie")