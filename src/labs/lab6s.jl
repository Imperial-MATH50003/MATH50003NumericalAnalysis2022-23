## 1. Least squares and QR decompositions

**Problem 1.1 (B)** Find and plot the best least squares fit of ${1 \over 5x^2 + 1}$ by degree $n$
polynomials for $n = 0,\ldots,10$ at 1000 evenly spaced points between $0$ and $1$.

**SOLUTION**
```julia
x = range(0, 1; length=1000)
pl = plot()
f = 1 ./ (5x.^2 .+ 1)
for n = 0:10
    # Creates 1000 x n+1 matrix with entries x[k]^(j-1)
    A = x .^ (0:n)'
    c = A \ f
    plot!(x, A*c)
end
pl
```
```julia
# Here is the same approach as above but this time explicitly using QR as discussed in the lecture notes:
x = range(0, 1; length=1000)
pl = plot()
f = 1 ./ (5x.^2 .+ 1)
for n = 0:10
    # Creates 1000 x n+1 matrix with entries x[k]^(j-1)
    A = x .^ (0:n)'
    (Q, R) = qr(A)
    c = R \ Q[:, 1:n+1]' * f
    plot!(x, A * c)
end
pl
```
**END**


**Problem 3.2 (B)** Complete the following function that implements
 Householder QR using only $O(mn^2)$ operations.
```julia
function householderqr(A)
    m,n = size(A)
    if m < n
        error("Only support more rows than columns")
    end
    # R begins as A, modify it in place
    R = copy(A)
    Q = Reflections(Matrix(1.0I, m, n))
    for j = 1:n
        # TODO: populate Q and R using O(m*(n-j)) operations
        ## SOLUTION
        y = copy(R[j:end, j])
        y[1] += ((y[1] ≥ 0) ? 1 : -1) * norm(y)
        w = y / norm(y)
        Q.V[j:end, j] = w
        R[j:end, :] = R[j:end, :] - 2 * w * (w' * R[j:end, :])
        ## END
    end
    Q,R
end

A = randn(4,6)
Q,R = householderqr(A)
@test Q*R ≈ A
@test Q'Q ≈ I
```

**SOLUTION**

Here we sketch some additional notes comparing performance.

```julia
# Here's a performance comparison with what we saw in the lecture notes:
function householderreflection(x)
    y = copy(x)
    # we cannot use sign(x[1]) in case x[1] == 0
    if x[1] ≥ 0
        y[1] += norm(x)
    else
        y[1] -= norm(x)
    end
    w = y / norm(y)
    I - 2 * w * w'
end
function lecturehouseholderqr(A)
    m,n = size(A)
    R = copy(A)
    Q = Matrix(1.0I, m, m)
    for j = 1:n
        Qⱼ = householderreflection(R[j:end,j])
        R[j:end,:] = Qⱼ*R[j:end,:]
        Q[:,j:end] = Q[:,j:end]*Qⱼ
    end
    Q,R
end

using BenchmarkTools

for j = 1:5
    A = randn(j*100,j*100)
    @btime lecturehouseholderqr(A);
end
```
```julia
for j = 1:5
    A = randn(j*100,j*100)
    @btime householderqr(A);
end
```

**END**


**Problem 4.2 (B)** Implement `Rotations` which represents an orthogonal matrix `Q` that is a product
of rotations of angle `θ[k]`, each acting on the entries `k:k+1`. That is, it returns $Q = Q_1⋯Q_k$ such that
$$
Q_k[k:k+1,k:k+1] = 
\begin{bmatrix}
\cos θ[k] & -\sin θ[k]\\
\sin θ[k] & \cos θ[k]
\end{bmatrix}
$$

```julia
struct Rotations{T} <: AbstractMatrix{T}
    θ::Vector{T}
end

import Base: *, size, getindex

size(Q::Rotations) = (length(Q.θ)+1, length(Q.θ)+1)


function *(Q::Rotations, x::AbstractVector)
    T = eltype(Q)
    y = convert(Vector{T}, x)
    # TODO: Apply Q in O(n) operations, modifying y in-place

    ## SOLUTION
    θ = Q.θ
    #Does Q1....Qn x
    for k = length(θ):-1:1
        #below has 4 ops to make the matrix and 12 to do the matrix-vector multiplication,
        #total operations will be 48n = O(n)
        c, s = cos(θ[k]), sin(θ[k])
        y[k:(k+1)] = [c -s; s c] * y[k:(k+1)]
    end
    ## END

    y
end

function getindex(Q::Rotations, k::Int, j::Int)
    # TODO: Return Q[k,j] in O(n) operations (hint: use *)

    ## SOLUTION
    #recall that A_kj = e_k'*A*e_j for any matrix A
    #so if we use * above, this will take O(n) operations
    n = size(Q)[1]
    ej = zeros(eltype(Q), n)
    ej[j] = 1
    #note, must be careful to ensure that ej is a VECTOR
    #not a MATRIX, otherwise * above will not be used
    Qj = Q * ej
    Qj[k]
    ## END
end

θ1 = randn(5)
Q = Rotations(θ1)
@test Q'Q ≈ I
@test Rotations([π/2, -π/2]) ≈ [0 0 -1; 1 0 0; 0 -1 0]
```

**Problem 4.3 (A)** Combine `Rotations` and `UpperTridiagonal` from last problem sheet
to implement a banded QR decomposition, `bandedqr`, that only takes $O(n)$ operations. Hint: use `atan(y,x)`
to determine the angle.
```julia
# First we include UpperTridiagonal from last problem sheet.
# bandedqr is below.
import Base: *, size, getindex, setindex!
struct UpperTridiagonal{T} <: AbstractMatrix{T}
    d::Vector{T}   # diagonal entries
    du::Vector{T}  # super-diagonal enries
    du2::Vector{T} # second-super-diagonal entries
end

size(U::UpperTridiagonal) = (length(U.d),length(U.d))

function getindex(U::UpperTridiagonal, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    # TODO: return U[k,j]
    if j - k == 0
        d[j]
    elseif j - k == 1
        du[k]
    elseif j - k == 2
        du2[k]
    else
        0
    end
end

function setindex!(U::UpperTridiagonal, v, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    if j > k+2
        error("Cannot modify off-band")
    end

    # TODO: modify d,du,du2 so that U[k,j] == v
    if j - k == 0
        d[k] = v
    elseif j - k == 1
        du[k] = v
    elseif j - k == 2
        du2[k] = v
    else
        error("Cannot modify off-band")
    end
    U = UpperTridiagonal(d,du,du2)

    U # by convention we return the matrix
end

function bandedqr(A::Tridiagonal)
    n = size(A, 1)
    Q = Rotations(zeros(n - 1)) # Assume Float64
    R = UpperTridiagonal(zeros(n), zeros(n - 1), zeros(n - 2))
    R[1, 1:2] = A[1, 1:2]
        
    for j = 1:n-1
        # angle of rotation
        Q.θ[j] = atan(A[j+1, j], R[j, j])
        θ = -Q.θ[j] # rotate in oppoiste direction 

        c, s = cos(θ), sin(θ)
        # [c -s; s c] represents the rotation that introduces a zero.

        ## TODO: modify rows k and k+1 of R to represent
        # applying the rotation. Note you will need to use row k+1 of A.
        
        ## SOLUTION
        # This is [c -s; s c] to j-th column, but ignore second row
        # which is zero
        R[j, j] = c * R[j, j] - s * A[j+1, j]
        # This is [c -s; s c] to (j+1)-th column
        R[j:j+1, j+1] = [c -s; s c] * [R[j, j+1]; A[j+1, j+1]]

        if j < n - 1
            # This is [c -s; s c] to (j+2)-th column, where R is still zero
            R[j:j+1, j+2] = [-s; c] * A[j+1, j+2]
        end
        ## END
    end
    Q, R
end

A = Tridiagonal([1, 2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4])
Q, R = bandedqr(A)
@test Q*R ≈ A
```
