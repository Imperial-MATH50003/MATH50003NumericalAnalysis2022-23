# # Lab 8: Function compression and the SVD

# This lecture will explore using the SVD to compress 2D functions sampled at an 
# evenly spaced grid. This is very much the same as image compression,
# but we will see that samples of smooth functions can be approximated by very small rank matrices.  
# This gives some intuition on why pictures tend to be low rank: most pictures have large portions that are "smooth".



# The following code samples a function on a grid in the square `[-1,1]^2`
# and plots the corresponding pixels:

using Plots, LinearAlgebra, Test

f = (x,y) -> exp(-x^2*sin(2y-1))

m,n = 150,100
x = range(-1, 1; length=n)
y = range(-1, 1; length=m)

F = f.(x', y) # equivalent to [f(x[j],y[k]) for k=1:m, j=1:n]

heatmap(x, y, F)

# **Problem 1** Complete the following function `fsample(f, m, n)` which takes in a function
# and returns its sample on a grid.

function fsample(f::Function, m::Int, n::Int)
    # TODO: return `f` sampled at an evenly spaced grid with
    ## SOLUTION
    x = range(-1, 1; length=n)
    y = range(-1, 1; length=m)
    f.(x', y)
    ## END
end

@test fsample(f, m, n) == F

# ------
# ## Singular values of 2D function samples 

# We will  see experimentally that the singular values 
# tell us something about the functions.  Recall from lectures 
# the singular value decomposition is a matrix factorization of a 
# matrix $A ∈ ℝ^{m × n}$ of the form
#
# $$
# A = U Σ V^⊤
# $$
#
# where $U ∈ ℝ^{m × r}$, $Σ ∈ ℝ^{r × r}$ and $V ∈ ℝ^{n × r}$, where $U$ and $V$
# have orthogonal columns and $Σ$ is diagonal.   The singular values are the diagonal entries of $Σ$.

# Note that `svdvals(A)` calculates the singular values of a matrix `A`, without calculating
# the `U` and `V` components.

# **Problem 2.1** Use `plot(...; yscale=:log10)` and `svdvals` to plot the singular values of 
# $f(x,y) = exp(-x^2*sin(2y-1))$ sampled at a $100 × 150$ evenly spaced grid on $[-1,1]^2$. 

## SOLUTION
F = fsample((x,y)->exp(-x^2*sin(2y-1)), 100, 150)
plot(svdvals(F); yscale=:log10)
## END

# **Problem 2.2** Repeat Problem 2.1, but plotting the first 20 singular values divided by `n` for `n = m = 50` `n = m = 100`, `n = m = 200` on the same figure.  What do you notice?  
# Hint: recall `plot!` adds a plot to an existing plot.

## SOLUTION
f = (x,y)->exp(-x^2*sin(2y-1))
plot(svdvals(fsample(f, 50, 50))[1:20]/50; yscale=:log10)
plot!(svdvals(fsample(f, 100, 100))[1:20]/100; yscale=:log10)
plot!(svdvals(fsample(f, 200, 200))[1:20]/200; yscale=:log10)

# we appear to be converging
## END

# **Problem 2.3** Plot the first 50 singular values for `n = m = 200` of `(x,y) -> cos(ω*x*y)` for `ω` equal to 1,10 and 50, on the same figure.  How do the singular values change as the function becomes more oscillatory?

## SOLUTION
f = (x,y) -> cos(ω*x*y)
ω  = 1; plot(svdvals(fsample(f, 200, 200))[1:50]; yscale=:log10)
ω  = 10; plot!(svdvals(fsample(f, 200, 200))[1:50]; yscale=:log10)
ω  = 50; plot!(svdvals(fsample(f, 200, 200))[1:50]; yscale=:log10)

# the singular values plateau when the function becomes oscillatory. 
## END

# **Problem 2.4** Plot the singular values of `(x,y)->sign(x-y)` for `n=m=100` and `n=m=200`.  What do you notice?   

f = (x,y) -> sign(x-y)
plot(svdvals(fsample(f, 200, 200)); yscale=:log10)

# -----
# ## Function compression

# We now turn to using the SVD to compress functions.

# **Problem 3.1** Write a function `svdcompress(A::Matrix, r::Integer)` that returns the best rank-`r` approximation to `A`.

# **Problem 3.2** Compare a `heatmap` plot of `F=fsample((x,y) -> exp(-x^2*sin(2y-1)), 100, 100)` to its best rank-5 approximation.

# **Problem 3.3** Write a function `svdcompress_rank(A::Matrix, ε::Float64)` that returns `r` so that `Ar = svdcompress(A,r)`  satisfies `norm(A-Ar) ≤ ε`,
# which we call the "numerical rank".  (Hint: use the singular values instead of guess-and-check.)

# **Problem 3.4** Plot the rank needed to achieve an accuracy of `1E-4` for `(x,y)->cos(ω*x*y)` as a function of `ω`, for `ω` ranging from `1` to `500` and `n=m=500`.  Can you conjecture what the rate of growth of the necessary rank is?

# ------
# Consider the Hilbert matrix H_n := [1/(k+j)]
# 
# **Problem 4.1** Write a function `lowrank_mul(U, σ, V, x)` that computes `Ax` but using
# the SVD of a matrix. 

# **Problem 4.2** Use `svdcompress_rank` to estimate how the numerical rank of $H_n$ grows as a function
# of $n$ for $ε = 10^(-10)$. 

