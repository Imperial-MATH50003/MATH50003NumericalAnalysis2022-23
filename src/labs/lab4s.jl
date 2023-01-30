
# ## 1. Array creation and broadcasting

# **Problem 1.1** Create a vector of length 5 whose entries are `Int` which is
# zero in all entries. (3 solutions: using `zeros`, `fill`, or a comprehension.)

## SOLUTION
# Here are 3 solutions:
# 1. `zeros`

zeros(Int, 5)

# 2. `fill`

fill(0, 5)

# 3. Comprehension

[0 for k=1:5]


## END

# **Problem 1.2** Create a 5×6 matrix whose entries are `Int` which is
# one in all entries. (4 solutions: using a for-loop, `ones``, `fill`, or a comprehension.) 

## SOLUTION

# 1. For-loop:

ret = zeros(Int, 5, 6)
for k=1:5, j=1:6
    ret[k,j] = 1
end
ret

# 2. Ones:

ones(Int, 5, 6)

# 3. Fill:

fill(1, 5, 6)

# 4. Comprehension

[1 for k=1:5, j=1:6]


## END

# **Problem 1.3** Create a 1 × 5 `Matrix{Int}` with entries `A[k,j] = j`. (2 solutions: a for-loop or a compregension.)


## SOLUTION

# 1. For-loop

A = zeros(Int, 1, 5)
for j = 1:5
    A[1,j] = j
end

# 2. Comprehension

[j for k=1:1, j=1:5]

# 3. convert transpose:

## Note: (1:5)' is a "row-vector" which behaves differently than a matrix
Matrix((1:5)')


## END

# **Problem 1.4** Create a vector of length 5 whose entries are `Float64`
# approximations of `exp(-k)`. (Two solutions: one using a for loop and
# one using broadcasting.)

## SOLUTION

1. For-loop
```julia
v = zeros(5) # defaults to Float64
for k = 1:5
    v[k] = exp(-k)
end
```
2. Broadcast:
```julia
exp.(-(1:5))
```
3. Explicit broadcsat:
```julia
broadcast(k -> exp(-k), 1:5)
```
4. Comprehension:
```julia
[exp(-k) for k=1:5]
```

## END

# **Problem 1.5** Create a 5 × 6 matrix `A` whose entries `A[k,j] == cos(k+j)`.

## SOLUTION

#  1. For-loop:

A = zeros(5,6)
for k = 1:5, j = 1:6
    A[k,j] = cos(k+j)
end
A

# 2. Broadcasting:

k = 1:5
j = 1:6
cos.(k .+ j')

# 3. Broadcasting (explicit):

broadcast((k,j) -> cos(k+j), 1:5, (1:6)')

## END


# MATH50003 Numerical Analysis: Problem 3

This problem sheet explores implementation of triangular solves,
supporting a matrix with two super-diagonals, as well as
permutation and Householder reflections that can be applied to a vector in
$O(n)$ complexity.

Questions marked with a ⋆ are meant to be completed without using a computer.
Problems are denoted A/B/C to indicate their difficulty.


```julia
using LinearAlgebra, Test

# We will override these functions below
import Base: getindex, setindex!, size, *, \
```

## 1. Dense Matrices

**Problem 1.1 (C)** Show that `A*x` is not
implemented as `mul(A, x)` from the lecture notes
by finding a `Float64` example  where the bits do not match.

**SOLUTION**

First we have to define `mul(A, x)` as in the lecture notes:
```julia
function mul(A, x)
    m,n = size(A)
    c = zeros(eltype(x), m) # eltype is the type of the elements of a vector/matrix
    for j = 1:n, k = 1:m
        c[k] += A[k, j] * x[j]
    end
    c
end
```
Then we can easily find examples, in fact we can write a function that searches for examples:
```julia
using ColorBitstring

function findblasmuldifference(n,l)
	for j = 1:n
		A = randn(l,l)
		x = rand(l)
		if A*x != mul(A,x) 
			return (A,x)
		end
	end
end

n = 100 # number of attempts
l = 10 # size of objects
(A,x) = findblasmuldifference(n,l) # find a difference

println("Bits of obtained A*x")
printlnbits.(A*x);
println("Bits of obtained mul(A,x)")
printlnbits.(mul(A,x));
println("Difference vector between the two solutions:")
println(A*x-mul(A,x))

```


## 2. Triangular Matrices

**Problem 2.1 (B)** Complete the following functions for solving linear systems with
triangular systems by implementing back and forward-substitution:
```julia
function ldiv(U::UpperTriangular, b)
    n = size(U,1)
    
    if length(b) != n
        error("The system is not compatible")
    end
        
    x = zeros(n)  # the solution vector
    ## TODO: populate x using back-substitution
end

function ldiv(U::LowerTriangular, b)
    n = size(U,1)
    
    if length(b) != n
        error("The system is not compatible")
    end
        
    x = zeros(n)  # the solution vector
    ## TODO: populate x using forward-substitution
end
```

**SOLUTION**


```julia
function ldiv(U::UpperTriangular, b)
    n = size(U,1)
    
    if length(b) != n
        error("The system is not compatible")
    end
        
    x = zeros(n)  # the solution vector
    
    for k = n:-1:1  # start with k=n, then k=n-1, ...
        r = b[k]  # dummy variable
        for j = k+1:n
            r -= U[k,j]*x[j] # equivalent to r = r-U[k,j]*x[j]
        end
        x[k] = r/U[k,k]
    end
    x
end

function ldiv(U::LowerTriangular, b)
    n = size(U,1)
    
    if length(b) != n
        error("The system is not compatible")
    end
        
    x = zeros(n)  # the solution vector

    for k = 1:n  # start with k=1
        r = b[k]  # dummy variable
        for j = 1:k-1
            r -= U[k,j]*x[j]
        end
        x[k] = r/U[k,k]
    end
    x
end
```

Here is an example:
```julia
x = [1,2,3,4]
Ldense = [1 0 0 0; 2 3 0 0; 4 5 6 0; 7 8 9 10]
Ltriang = LowerTriangular(Ldense)
```
```julia
Ldense\x-ldiv(Ltriang,x)
```



**Problem 2.2⋆ (B)** Given $𝐱 \in \mathbb{R}^n$, find a lower triangular matrix of the form
$$
L = I - 2 𝐯 𝐞_1^⊤
$$
such that:
$$
L 𝐱 = x_1 𝐞_1.
$$
What does $L𝐲$ equal if $𝐲  ∈ ℝ^n$ satisfies $y_1 = 𝐞_1^⊤ 𝐲 = 0$?

**SOLUTION**

By straightforward computation we find

$$Lx = x - 2 𝐯 𝐞_1^⊤x = x - 2 𝐯 x_1$$

and thus we find such a lower triangular $L$ by choosing $v_1 = 0$ and $v_k = \frac{x_k}{2 x_1}$ for $k=2..n$ and $x_1 \neq 0$.

## 3. Banded matrices

**Problem 3.1 (C)** Complete the implementation of `UpperTridiagonal` which represents a banded matrix with
bandwidths $(l,u) = (0,2)$:
```julia
struct UpperTridiagonal{T} <: AbstractMatrix{T}
    d::Vector{T}   # diagonal entries
    du::Vector{T}  # super-diagonal enries
    du2::Vector{T} # second-super-diagonal entries
end

size(U::UpperTridiagonal) = (length(U.d),length(U.d))

function getindex(U::UpperTridiagonal, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    # TODO: return U[k,j]
end

function setindex!(U::UpperTridiagonal, v, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    if j > k+2
        error("Cannot modify off-band")
    end

    # TODO: modify d,du,du2 so that U[k,j] == v

    U # by convention we return the matrix
end
```

**SOLUTION**


```julia
struct UpperTridiagonal{T} <: AbstractMatrix{T}
    d::Vector{T}   # diagonal entries
    du::Vector{T}  # super-diagonal enries
    du2::Vector{T} # second-super-diagonal entries
end

size(U::UpperTridiagonal) = (length(U.d),length(U.d))

function getindex(U::UpperTridiagonal, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2

    if j == k+2
    	return U.du2[k]    
    elseif j == k+1
    	return U.du[k]
    elseif j == k
    	return U.d[k]
    else # off band entries are zero
    	return zero(eltype(U))
    end
end

function setindex!(U::UpperTridiagonal, v, k::Int, j::Int)
    d,du,du2 = U.d,U.du,U.du2
    if (j > k+2)||(j<k)
        error("Cannot modify off-band")
    end

    if j == k+2
    	U.du2[k] = v  
    elseif j == k+1
    	U.du[k] = v
    elseif j == k
    	U.d[k] = v
    end

    U # by convention we return the matrix
end
```

We can check that the above methods to read and write entries work:

```julia
A = UpperTridiagonal([1,2,3,4], [1,2,3], [1,2])
```
```julia
A[1,1] = 2
A
```

**Problem 3.2 (B)** Complete the following implementations of `*` and `\` for `UpperTridiagonal` so that
they take only $O(n)$ operations.
```julia
function *(U::UpperTridiagonal, x::AbstractVector)
    T = promote_type(eltype(U), eltype(x)) # make a type that contains both the element type of U and x
    b = zeros(T, size(U,1)) # returned vector
    # TODO: populate b so that U*x == b (up to rounding)
end

function \(U::UpperTridiagonal, b::AbstractVector)
    T = promote_type(eltype(U), eltype(b)) # make a type that contains both the element type of U and b
    x = zeros(T, size(U,2)) # returned vector
    # TODO: populate x so that U*x == b (up to rounding)
end
```

**SOLUTION**
```julia
function *(U::UpperTridiagonal, x::AbstractVector)
    T = promote_type(eltype(U), eltype(x)) # make a type that contains both the element type of U and x
    b = zeros(T, size(U,1)) # returned vector
    n = size(U)[1]
    for k = 1:n-2
    	b[k] = dot(U[k,k:k+2],x[k:k+2])
    end
    # the last two rows need a bit more care
    b[n-1] = dot(U[n-1,n-1:n],x[n-1:n])
    b[n] = U[n,n]*x[n]
    return b
end

function \(U::UpperTridiagonal, b::AbstractVector)
    T = promote_type(eltype(U), eltype(b)) # make a type that contains both the element type of U and b
    x = zeros(T, size(U,2)) # returned vector
    n = size(U)[1]
    
    if length(b) != n
        error("The system is not compatible")
    end
    
    for k = n:-1:1  # start with k=n, then k=n-1, ...
        r = b[k]  # dummy variable
        for j = k+1:min(k+3,n)
            r -= U[k,j]*x[j]
        end
        x[k] = r/U[k,k]
    end
    x
end
```

And here is an example of what we have implemented in action:

```julia
Abanded = UpperTridiagonal([1.1,2.2,3.3,4.4], [1.9,2.8,3.7], [1.5,2.4])
Adense = Matrix(Abanded) # one of many easy ways to convert to dense storage

Adense == Abanded
```

```julia
x = [5.2,3/4,2/3,9.1415]
Adense*x
```

```julia
Abanded*x
```

```julia
Adense\x
```

```julia
Abanded\x
```

And just for fun, let's do a larger scale dense speed comparison
```julia
using BenchmarkTools
n = 10000
Abanded = UpperTridiagonal(rand(n),rand(n-1),rand(n-2))
Adense = Matrix(Abanded) # one of many easy ways to convert to dense storage
x = rand(n)

@btime Adense*x;

```
```julia
@btime Abanded*x;

```
```julia
@btime Adense\x;

```
```julia
@btime Abanded\x;

```
