# # MATH50003 Numerical Analysis (2022–23)
# # Lab 5: Orthogonal Matrices

# This lab explores orthogonal matrices, including permutations and reflections.
# We will construct special types to capture the structure of these orthogonal operations,
# With the goal of implementing fast matrix*vector and matrix\vector operations.

# ------

# **Problem 1** Complete the implementation of a type representing
# permutation matrices that supports `P[k,j]` and such that `*` takes $O(n)$ operations.

using LinearAlgebra, Test
import Base: getindex, *, size, \

struct PermutationMatrix <: AbstractMatrix{Int}
    p::Vector{Int} # represents the permutation whose action is v[p]
    ## This is an internal constructor: allows us to check validity of the input.
    function PermutationMatrix(p::Vector)
        sort(p) == 1:length(p) || error("input is not a valid permutation")
        new(p)
    end
end

function size(P::PermutationMatrix)
    (length(P.p),length(P.p))
end
using LinearAlgebra, Test
import Base: getindex, *, size, \

struct PermutationMatrix <: AbstractMatrix{Int}
    p::Vector{Int} # represents the permutation whose action is v[p]
    ## This is an internal constructor: allows us to check validity of the input.
    function PermutationMatrix(p::Vector)
        sort(p) == 1:length(p) || error("input is not a valid permutation")
        new(p)
    end
end

function size(P::PermutationMatrix)
    (length(P.p),length(P.p))
end

## getindex(P, k, j) is a synonym for P[k,j]
function getindex(P::PermutationMatrix, k::Int, j::Int)
    ## TODO: Implement P[k,j]
    ## SOLUTION
    ## P.p[k] == j ? 1 : 0 
    if P.p[k] == j
        1
    else 
        0
    end
    ## END
end
function *(P::PermutationMatrix, x::AbstractVector)
    ## TODO: return a vector whose entries are permuted according to P.p
    ## SOLUTION
    x[P.p]
    ## END
end

## If your code is correct, this "unit test" will succeed
p = [1, 4, 2, 5, 3]
P = PermutationMatrix(p)
@test P == I(5)[p,:]

n = 1_000_000
p = Vector(n:-1:1) # makes a Vector corresponding to [n,n-1,…,1]
P = PermutationMatrix(p)
x = randn(n)
@test P*x == x[p]


# -------

# **Problem 2.1** Complete the implementation of a type representing
# reflections that supports `Q[k,j]` and such that `*` takes $O(n)$ operations.

## Represents I - 2v*v'
struct Reflection{T} <: AbstractMatrix{T}
    v::Vector{T}
end

Reflection(x::Vector{T}) where T = Reflection{T}(x/norm(x))

function size(Q::Reflection)
    (length(Q.v),length(Q.v))
end
# getindex(Q, k, j) is synonym for Q[k,j]
function getindex(Q::Reflection, k::Int, j::Int)
    ## TODO: implement Q[k,j] == (I - 2v*v')[k,j] but using O(1) operations
    ## SOLUTION
    if k == j
        1 - 2Q.v[k]*Q.v[j]
    else
        - 2Q.v[k]*Q.v[j]
    end
    ## END
end
function *(Q::Reflection, x::AbstractVector)
    ## TODO: implement Q*x, equivalent to (I - 2v*v')*x but using only O(n) operations
    ## SOLUTION
    x - 2*Q.v * dot(Q.v,x) # (Q.v'*x) also works instead of dot
    ## END
end

# If your code is correct, these "unit tests" will succeed
n = 1_000_000
x = randn(n) + im*randn(n)
Q = Reflection(x)
v = x/norm(x)
@test Q == I-2v*v'
@test Q*v ≈ -v
@test Q'Q ≈ I



# **Problem 2.2** Complete the following implementation of a Housholder reflection  so that the
# unit tests pass. Here `s == true` means the Householder reflection is sent to the positive axis and `s == false` is the negative axis.

function householderreflection(s::Bool, x::AbstractVector)
    ## TODO: return a `Reflection` corresponding to a Householder reflection
    ## SOLUTION
    y = copy(x) # don't modify `x`
    if s
        y[1] -= norm(x)
    else
        y[1] += norm(x)
    end
    Reflection(y)
    ## END
end

x = randn(5)
Q = householderreflection(true, x)
@test Q isa Reflection
@test Q*x ≈ [norm(x);zeros(eltype(x),length(x)-1)]

Q = householderreflection(false, x)
@test Q isa Reflection
@test Q*x ≈ [-norm(x);zeros(eltype(x),length(x)-1)]


# ---------

# **Problem 3**
# Complete the definition of `Reflections` which supports a sequence of reflections,
# that is,
# $$
# Q = Q_{𝐯_1} ⋯ Q_{𝐯_n}
# $$
# where the vectors are stored as a matrix `V` whose $j$-th column is $𝐯_j$, and
# $$
# Q_{𝐯_j} = I - 2 𝐯_j 𝐯_j^⊤.
# $$


struct Reflections{T} <: AbstractMatrix{T}
    V::Matrix{T}
end

size(Q::Reflections) = (size(Q.V,1), size(Q.V,1))


function *(Q::Reflections, x::AbstractVector)
    T = promote_type(eltype(Q), eltype(x))
    r = Vector{T}(x) # convert x to a vector of type T
    # TODO: Apply Q in O(mn) operations by applying
    # the reflection corresponding to each column of Q.V to r
    
    ## SOLUTION
    m,n = size(Q.V)
    for j = n:-1:1
        r = Reflection(Q.V[:, j]) * r
    end
    ## END

    r
end

function getindex(Q::Reflections, k::Int, j::Int)
    # TODO: Return Q[k,j] in O(mn) operations (hint: use *)

    ## SOLUTION
    T = eltype(Q.V)
    m,n = size(Q)
    ej = zeros(T, m)
    ej[j] = one(T)
    return (Q*ej)[k]
    ## END
end

Y = randn(5,3)
V = Y * Diagonal([1/norm(Y[:,j]) for j=1:3])
Q = Reflections(V)
@test Q ≈ (I - 2V[:,1]*V[:,1]')*(I - 2V[:,2]*V[:,2]')*(I - 2V[:,3]*V[:,3]')
@test Q'Q ≈ I


