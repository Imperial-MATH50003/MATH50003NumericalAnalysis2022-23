# # MATH50003 Numerical Analysis (2022–23)
# # Lab 4: Structured Matrices

# This lab explores the basics of arrays (matrices and vectors)
# in Julia. We also investigate implementation of triangular solves,
# supporting a matrix with two super-diagonals.

# Note in programming there are often different ways to do the same thing.
# so some of the hints suggest multiple ways to solve the same problem.
# Remember you can use `?` to discover the functions mentioned in the hints.


using LinearAlgebra, Test

## We will override these functions below
import Base: getindex, setindex!, size, *, \



# ## 1. Array creation

# **Problem 1.1** Create a vector of length 5 whose entries are `Int` which is
# zero in all entries. Hint: use `zeros`, `fill`, or a comprehension.



# **Problem 1.2** Create a 5×6 matrix whose entries are `Int` which is
# one in all entries. Hint: use a for-loop, `ones`, `fill`, or a comprehension.



# **Problem 1.3** Create a 1 × 5 `Matrix{Int}` with entries `A[k,j] = j`. Hint: use a for-loop or a comprehension.




# **Problem 1.4** Create a vector of length 5 whose entries are `Float64`
# approximations of `exp(-k)`. Hint: one use a for-loop or broadcasting `f.(x)` notation.



# **Problem 1.5** Create a 5 × 6 matrix `A` whose entries `A[k,j] == cos(k+j)`.





# ## 2. Dense Matrices


# **Problem 2.1** Show that `A*x` is not
# implemented as `mul_cols(A, x)` from the lecture notes
# by finding a `Float64` example  where the bits do not match.



# ## 3. Triangular Matrices

# **Problem 3.1** Complete the following function for lower triangular matrix-vector
# multiplication without ever accessing the zero entries of `L` above the diagonal.
# Hint: just copy code for `mul_cols` and modify the for-loop ranges a la the `UpperTriangular`
# case.

function mul_cols(L::LowerTriangular, x)
    n = size(L,1)

    ## promote_type type finds a type that is compatible with both types, eltype gives the type of the elements of a vector / matrix
    T = promote_type(eltype(x),eltype(L))
    b = zeros(T,n) # the returned vector, begins of all zeros

    ## TODO: populate b so that L*x == b
    

    b
end

L = LowerTriangular(randn(5,5))
x = randn(5)
@test_broken L*x == mul_cols(L, x)


# **Problem 3.2** Complete the following function for solving linear systems with
# lower triangular systems by implementing forward-substitution.


function ldiv(L::LowerTriangular, b)
    n = size(L,1)
    
    if length(b) != n
        error("The system is not compatible")
    end
        
    x = zeros(n)  # the solution vector
    ## TODO: populate x using forward-substitution so that L*x ≈ b
    
    x
end


L = LowerTriangular(randn(5,5))
b = randn(5)
@test_broken L\b ≈ ldiv(L, b)


# ## 4. Banded matrices

# **Problem 4.1** Complete the implementation of `UpperTridiagonal` which represents a banded matrix with
# bandwidths $(l,u) = (0,2)$:

struct UpperTridiagonal{T} <: AbstractMatrix{T}
    d::Vector{T}   # diagonal entries: d[k] == U[k,k]
    du::Vector{T}  # super-diagonal enries: du[k] == U[k,k+1]
    du2::Vector{T} # second-super-diagonal entries: du2[k] == U[k,k+2]
end

size(U::UpperTridiagonal) = (length(U.d),length(U.d))

## getindex(U, k, j) is another way to write U[k,j].
## This function will therefore be called when we call U[k,j]
function getindex(U::UpperTridiagonal, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    ## TODO: return U[k,j]
    
end

## setindex!(U, v, k, j) gets called when we write (U[k,j] = v).
function setindex!(U::UpperTridiagonal, v, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    if j > k+2 || j < k
        error("Cannot modify off-band")
    end

    ## TODO: modify d,du,du2 so that U[k,j] == v
    
    U # by convention we return the matrix
end

U = UpperTridiagonal([1,2,3,4,5], [1,2,3,4], [1,2,3])
@test_broken U == [1 1 1 0 0;
            0 2 2 2 0;
            0 0 3 3 3;
            0 0 0 4 4;
            0 0 0 0 5]



# **Problem 4.2** Complete the following implementations of `*` and `\` for `UpperTridiagonal` so that
# they take only $O(n)$ operations.

function *(U::UpperTridiagonal, x::AbstractVector)
    n = size(U,1)
    ## promote_type type finds a type that is compatible with both types, eltype gives the type of the elements of a vector / matrix
    T = promote_type(eltype(x),eltype(U))
    b = zeros(T, n) # the returned vector, begins of all zeros
    ## TODO: populate b so that U*x == b (up to rounding)
    
    b
end

function \(U::UpperTridiagonal, b::AbstractVector)
    n = size(U,1)
    T = promote_type(eltype(b),eltype(U))

    if length(b) != n
        error("The system is not compatible")
    end
        
    x = zeros(T, n)  # the solution vector
    ## TODO: populate x so that U*x ≈ b
    
    x
end

n = 1_000_000 # under-scores are like commas: so this is a million: 1,000,000
U = UpperTridiagonal(ones(n), fill(0.5,n-1), fill(0.1,n-2))
x = ones(n)
b = [fill(1.6,n-2); 1.5; 1] # exact result
## note following should take much less than a second
@test_broken U*x == b
@test_broken U\b == x