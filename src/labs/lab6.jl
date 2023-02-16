# # MATH50003 Numerical Analysis (2022–23)
# # Lab 6: Least squares, QR and Cholesky
# This lab explores the the least squares problem for fitting functions with polynomials,
# computing the QR factorisation with both reflections and rotations,
# and implementing a tridiagonal Cholesky decomposition (which we shall see later arises in the 1D Poisson equation).

using Plots, Test, LinearAlgebra

# ------

# When $m = n$ a least squares fit by a polynomial becomes _interpolation_:
# the approximating polynomial will fit the data exactly. That is, for
# $$
# p(x) = ∑_{k = 0}^{n-1} p_k x^k
# $$
# and $x_1, …, x_n ∈ ℝ$, we choose $p_k$ so that $p(x_j) = f(x_j)$ for
# $j = 1, …, n$. 

# **Problem 1.1** Complete the following function which returns a  _Vandermonde matrix_:
# a matrix $V ∈ ℝ^{n × n}$ such that
# $$
# V * \begin{bmatrix} p_0\\ … \\p_n \end{bmatrix} = \begin{bmatrix} p(x_1)\\ … \\p(x_m) \end{bmatrix}
# $$

function vandermonde(𝐱) # 𝐱 = [x_1,…,x_n]
    n = length(𝐱)
    ## TODO: Make V
    ## SOLUTION
    ## There are also solutions using broadcasting or for loops.
    [𝐱[j]^k for j = 1:n, k = 0:n-1]
    ## END
end

n = 1000
𝐱 = range(0, 0.5; length=n)
V = vandermonde(𝐱)
## if all coefficients are 1 then p(x) = (1-x^n)/(1-x)
@test V * ones(n) ≈ (1 .- 𝐱 .^ n) ./ (1 .- 𝐱)


# Inverting the Vandermonde matrix is a way of computing coefficients from function
# samples. That is, solving
# $$
# V𝐜 = \begin{bmatrix} f(x_1) \\ ⋮ \\ f(x_n) \end{bmatrix}
# $$
# Gives the coefficients of a polynomial $p(x)$ so that $p(x_j) = f(x_j)$.
# Whether an interpolation is actually close to a function is a subtle question,
# involving properties of the function, distribution of the sample points $x_1,…,x_n$,
# and round-off error.
# A classic example is:
# $$
#   f_M(x) = {1 \over M x^2 + 1}
# $$
# where the choice of $M$ can dictate whether interpolation at evenly spaced points converges.


# **Problem 1.2** Find and plot the best least squares fit of $f_M$ by degree $n$
# polynomials for $n = 0,…,10$ at 1000 evenly spaced points between $0$ and $1$.




# ------- 

# **Problem 2** Complete the following function that implements
#  Householder QR using only $O(mn^2)$ operations.
# You may choose to use your implementation of `Reflection` and `Reflections` from PS5.
# Hint: to find the inner product of a vector `w` with each column of a matrix 
# `R` one can write `w'R`.
function householderqr(A)
    T = eltype(A)
    m,n = size(A)
    if m < n
        error("Only support more than or equal rows than columns")
    end
    ## TODO: construct Q and R using O(m*n^2) operations
    ## via Householder reflections.
    
end

A = randn(6,4)
Q,R = householderqr(A)
@test_broken Q*R ≈ A
@test_broken Q'Q ≈ I


# ------

# An alternative to using reflections to introduce zeros is to use rotations.
# This is particularly convenient for tridiagonal matrices, where one needs to only
# make one sub-diagonal zero. Here we explore a tridiagonal QR built from rotations
# in a way that the factorisation can be computed in $O(n)$ operations.


# **Problem 3.1** Complete the implementation of `Rotations`, which represents an orthogonal matrix `Q` that is a product
# of rotations of angle `θ[k]`, each acting on the entries `k:k+1`. That is, it returns $Q = Q_1⋯Q_k$ such that
# $$
# Q_k[k:k+1,k:k+1] = 
# \begin{bmatrix}
# \cos θ[k] & -\sin θ[k]\\
# \sin θ[k] & \cos θ[k]
# \end{bmatrix}
# $$

struct Rotations{T} <: AbstractMatrix{T}
    θ::Vector{T} # a vector of angles
end

import Base: *, size, getindex

## we use the number of rotations to deduce the dimensions of the matrix
size(Q::Rotations) = (length(Q.θ)+1, length(Q.θ)+1)

function *(Q::Rotations, x::AbstractVector)
    T = promote_type(eltype(Q), eltype(x))
    y = Vector{T}(x) # copies x to a new Vector whose eltype is T
    ## TODO: Apply Q in O(n) operations, modifying y in-place

    

    y
end

function getindex(Q::Rotations, k::Int, j::Int)
    ## TODO: Return Q[k,j] in O(n) operations (hint: use *)

    
end

θ1 = randn(5)
Q = Rotations(θ1)
@test_broken Q'Q ≈ I
@test_broken Rotations([π/2, -π/2]) ≈ [0 0 -1; 1 0 0; 0 -1 0]

# When one computes a tridiagonal QR, we introduce entries in the
# second super-diagonal. Thus we will use the `UpperTridiagonal` type
# from Lab 4:

import Base: *, size, getindex, setindex!
struct UpperTridiagonal{T} <: AbstractMatrix{T}
    d::Vector{T}   # diagonal entries
    du::Vector{T}  # super-diagonal enries
    du2::Vector{T} # second-super-diagonal entries
end

size(U::UpperTridiagonal) = (length(U.d),length(U.d))

function getindex(U::UpperTridiagonal, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    ## TODO: return U[k,j]
    
end

function setindex!(U::UpperTridiagonal, v, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    if j > k+2
        error("Cannot modify off-band")
    end

    ## TODO: modify d,du,du2 so that U[k,j] == v
    

    U # by convention we return the matrix
end


# **Problem 3.2** Combine `Rotations` and `UpperTridiagonal` from last problem sheet
# to implement a banded QR decomposition, `bandedqr`, that only takes $O(n)$ operations. Hint: the
# `atan(y,x)` function gives the angle of a vector [x,y].


function bandedqr(A::Tridiagonal)
    n = size(A, 1)
    Q = Rotations(zeros(n - 1)) # Assume Float64
    R = UpperTridiagonal(zeros(n), zeros(n - 1), zeros(n - 2))

    ## TODO: Populate Q and R by looping through the columns of A.

    
    Q, R
end

A = Tridiagonal([1, 2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4])
Q, R = bandedqr(A)
@test_broken Q*R ≈ A

# --------

# We now consider a Cholesky factorisation for tridiagonal matrices. Since we are assuming the
# matrix is symmetric, we will use a special type `SymTridiagonal` that captures the symmetry.
# In particular, `SymTridiagonal(dv, eu) == Tridiagonal(ev, dv, ev)`.

# **Problem 4** Complete the following
# implementation of `mycholesky` to return a `Bidiagonal` cholesky factor in $O(n)$ operations.


## return a Bidiagonal L such that L'L == A (up to machine precision)
## You are allowed to change A
function mycholesky(A::SymTridiagonal)
    d = A.dv # diagonal entries of A
    u = A.ev # sub/super-diagonal entries of A
    T = float(eltype(A)) # return type, make float in case A has Ints
    n = length(d)
    ld = zeros(T, n) # diagonal entries of L
    ll = zeros(T, n-1) # sub-diagonal entries of L

    

    Bidiagonal(ld, ll, :L)
end

n = 1000
A = SymTridiagonal(2*ones(n),-ones(n-1))
L = cholesky(A)
@test_broken L ≈ cholesky(Matrix(A)).L
