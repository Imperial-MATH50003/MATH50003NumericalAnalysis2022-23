# # MATH50003 (2022–23)
# # Lab 2: Interval arithmetic

# This lab explores the usage of rounding modes for floating point arithmetic and how they
# can be used to compute _rigorous_ bounds on mathematical constants such as ℯ.
# The key idea is _interval arithmetic_.
# That is recall the set operations
# $$
# A + B = \{x + y : x ∈ A, y ∈ B\}, AB = \{xy : x ∈ A, y ∈ B\}, A/B = \{x/y : x ∈ A, y ∈ B\}
# $$
#
# We will use floating point arithmetic to construct approximate set operations ⊕, ⊗ so that
# $$
#   A + B ⊆ A ⊕ B, AB ⊆ A ⊗ B, A/B ⊆ A ⊘ B
# $$
# thereby a complicated algorithm can be run on sets and the true result is guaranteed to be
# a subset of the output. E.g. we can do $ℯ = {\rm exp}(1) ∈ {\rm exp}([1,1]) ⊆ {\rm exp}^{\rm FP}([1,1])$
# where ${\rm exp}^{\rm FP}$ is implemented using $⊕$ and $⊗$.
#
# This will be consist of the following:
# 1. The finite Taylor series $\exp x ≈ ∑_{k=0}^n x^k/k!$ where each operation is now
#    an interval operation
# 2. A bound on $∑_{k=n+1}^∞ x^k/k!$ that we capture in the returned result
#
#
# In what follows, the starred (⋆) problems are meant to be done with pen-and-paper.
# We need the following packages:

using SetRounding, Test

# -----
#
# **Problem 1⋆** For intervals $A = [a,b]$ and $B = [c,d]$ such that $0 ∉ A,B$
#  and integer $n ≠ 0$, 
# deduce formulas for the minimum and maximum of $A/n$, $A+B$ and $AB$.
#
# -----
# We want to implement floating point variants such that, for $S = [a,b] + [c,d]$
#  $P = [a,b] * [c,d]$, and $D = [a,b]/n$ for an integer $n$,
# $$
# \begin{align*}
# [a,b] ⊕ [c,d] &:= [{\rm fl}^{\rm down}(\min S), {\rm fl}^{\rm up}(\max S)] \\
# [a,b] ⊗ [c,d] &:= [{\rm fl}^{\rm down}(\min P), {\rm fl}^{\rm up}(\max P)] \\
# [a,b] ⊘ n &:= [{\rm fl}^{\rm down}(\min D), {\rm fl}^{\rm up}(\max D)]
# \end{align*}
# $$
# This guarantees $S ⊆ [a,b] ⊕ [c,d]$, $P ⊆ [a,b] ⊗ [c,d]$, and
# $D ⊆ [a,b] ⊘ n$.
# In other words, if $x ∈ [a,b]$ and
# $y ∈ [c,d]$ then $x +y ∈ [a,b] ⊕ [c,d]$, and we thereby have  bounds on $x + y$.
#
# 
# We will now create a Type to represent an interval, which we will call `Interval`.
# We need two fields: the left endpoint (`a`) and a right endpoint (`b`). We want to allow
# these to be a type `T` which may be, say, `Int`, `Float64`, `Float16`, or `BigFloat`.
# To construct such a type we use the `struct` keyword:

struct Interval{T}
    a::T
    b::T
end

# For example, if we say `A = Interval(1, 2)` this corresponds to the mathematical interval
# $[1, 2]$, and the fields are accessed via `A.a` and `A.b`.
# Here we create an instance of such an interval interval:

A = Interval(1, 2) 

# This displays (prints out) as `Interval{Int64}(1, 2)`. The `{Int64}` indicates that the fields
# `A.a` and `A.b` are `Int64`. We can see this as follows:

A.a, A.b # returns a Tuple containing two Ints

# We will overload *, +, -, / to use interval arithmetic. That is, whenever we do arithmetic with
# an instance of `Interval` we want it to use correctly rounded interval varients. 
# We also need to support `one` (a function that creates an interval containing a single point `1`)
# and `in` functions (a function to test if a number is within an interval).
# To overload these functions we need to import them as follows:

import Base: *, +, -, /, one, in


# We can overload `one` as follows to create an interval corresponding to $[1,1]$.
# First note that the `one(T)` function will create the "multiplicative identity"
# for a given type. For example `one(Int)` will return `1`, `one(Float64)` returns `1.0`,
# and `one(String)` returns "" (because `"" * "any string" == "any string"`):

one(Int), one(Int64), one(String)

# We can also just call it on an instance of the type:

one(2), one(2.0), one("any string")

# For an interval the multiplicative identity is the interval whose lower and upper limit are both 1.
# To ensure its the right type we call `one(A.a)` and `one(A.b)`

one(A::Interval) = Interval(one(A.a), one(A.b))

# Thus the following returns an interval whose endpoints are both `1.0`:

one(Interval(2.0,3.3))

# Now if `A = Interval(a,b)` this corresponds to the mathematical interval $[a,b]$.
# And a real number $x ∈ [a,b]$ iff $a ≤ x ≤ b$. In Julia the endpoints $a$ and $b$ are accessed
# via $A.a$ and $B.b$ hence the above test becomes `A.a ≤ x ≤ A.b`. Thus we overload `in` 
# as follows:

in(x, A::Interval) = A.a ≤ x ≤ A.b

# The function `in` is whats called an "infix" operation (just like `+`, `-`, `*`, and `/`). We can call it
# either as `in(x, A)` or put the `in` in the middle and write `x in A`. This can be seen in the following:

A = Interval(2.0,3.3)
## 2.5 in A is equivalent to in(2.5, A)
## !(3.4 in A) is equivalent to !in(3.4, A)
2.5 in A, !(3.4 in A)

# The first problem now is to overload arithmetic operations to do the right thing.

# **Problem 2**  Use the formulae from Problem 1 to complete (by replacing the `# TODO: …` comments with code)
#  the following implementation of an 
# `Interval` 
# so that `+`, `-`, and `/` implement $⊕$, $⊖$, and $⊘$ as defined above.




# Hint: Like `in`, `+` is an infix operation, so if `A isa Interval` and `B isa Interval`
# then the following function will be called when we call `A + B`.
# We want it to  implement `⊕` as worked out by hand by replacing the `# TODO` with
# the correct interval versions. For example, for the first `# TODO`, we know the lower bound of
# $A + B$ is $a + c$, where $A = [a,b]$ and $B = [c,d]$. But in Julia we access the lower bound of $A$ ($a$)
# via `A.a` and the lower bound of $B$ via `B.a`.
# Thus just replace the first `#TODO` with `A.a + B.a`.

# You can probably ignore the `T = promote_type(...)` line for now: it is simply finding the right type
# to change the rounding mode by finding the "bigger" of the type of `A.a` and `B.a`. So in the examples below
# `T` will just become `Float64`.
# Finally, the code block
# ```julia
# setrounding(T, RoundDown) do
#
# end
# ```
# changes the rounding mode of floating point operations corresponding to the type `T` of the CPU, for any code between
# the `do` and the `end`.

function +(A::Interval, B::Interval)
    T = promote_type(typeof(A.a), typeof(B.a))
    a = setrounding(T, RoundDown) do
        ## TODO: lower bound
        
    end
    b = setrounding(T, RoundUp) do
        ## TODO: upper bound
        
    end
    Interval(a, b)
end

## following example was the non-associative example but now we have bounds
@test_broken Interval(1.1,1.1) + Interval(1.2,1.2) + Interval(1.3,1.3) ≡ Interval(3.5999999999999996, 3.6000000000000005)


# The following function is called whenever we divide an interval by an `Integer` (think of `Integer` for now
# a "superset" containing all integer types, e.g. `Int8`, `Int`, `UInt8`, etc.). Again we want it to return the
# set operation ⊘ with correct rounding.
# Be careful about whether `n` is positive or negative, and you may want to test if `n > 0`. To do so, use an
# `if-else-end` block:
# ```julia
# if COND1
#     # do this if COND1 == true
# else
#     # do this if COND1 == false
# end
# ```
function /(A::Interval, n::Integer)
    T = typeof(A.a)
    if iszero(n)
        error("Dividing by zero not support")
    end
    a = setrounding(T, RoundDown) do
        ## TODO: lower bound
        
    end
    b = setrounding(T, RoundUp) do
        ## TODO: upper bound
        
    end
    Interval(a, b)
end

@test_broken Interval(1.0,2.0)/3 ≡ Interval(0.3333333333333333, 0.6666666666666667)
@test_broken Interval(1.0,2.0)/(-3) ≡ Interval(-0.6666666666666667, -0.3333333333333333)

# Now we need to overload `*` to behave like the operation `⊗` defined above.
# Now you will need to use an if-elseif-else-end block:
# ```julia
# if COND1
#   # Do this if COND1 == true
# elseif COND2
#   # Do this if COND1 == false and COND2 == true
# elseif COND3
#   # Do this if COND1 == COND2 == false and COND3 == true
# else
#   # Do this if COND1 == COND2 == COND3 == false
# end
# ```
# You will also have to test whether multiple conditions are true.
# The notation `COND1 && COND2` returns true if `COND1` and `COND2` are both true.
# The notation `COND1 || COND2` returns true if either `COND1` or `COND2` are true.
# So for example the statement `0 in A || 0 in B` returns `true` if either interval `A`
# or `B` contains `0`.

function *(A::Interval, B::Interval)
    T = promote_type(typeof(A.a), typeof(B.a))
    if 0 in A || 0 in B
        error("Multiplying with intervals containing 0 not supported.")
    end
    if A.a > A.b || B.a > B.b
        error("Empty intervals not supported.")
    end
    a = setrounding(T, RoundDown) do
        ## TODO: lower bound
        
    end
    b = setrounding(T, RoundUp) do
        ## TODO: upper bound
        
    end
    Interval(a, b)
end

@test_broken Interval(1.1, 1.2) * Interval(2.1, 3.1) ≡ Interval(2.31, 3.72)
@test_broken Interval(-1.2, -1.1) * Interval(2.1, 3.1) ≡ Interval(-3.72, -2.31)
@test_broken Interval(1.1, 1.2) * Interval(-3.1, -2.1) ≡ Interval(-3.72, -2.31)
@test_broken Interval(-1.2, -1.1) * Interval(-3.1, -2.1) ≡ Interval(2.31, 3.72)

# -----

# The following function  computes the first `n+1` terms of the Taylor series of $\exp(x)$:
# $$
# \sum_{k=0}^n {x^k \over k!}
# $$
# (similar to the one seen in lectures).

function exp_t(x, n)
    ret = one(x) # 1 of same type as x
    s = one(x)
    for k = 1:n
        s = s/k * x
        ret = ret + s
    end
    ret
end


# **Problem 3.1⋆** Bound the tail of the Taylor series for ${\rm e}^x$ assuming $|x| ≤ 1$. 
# (Hint: ${\rm e}^x ≤ 3$ for $x ≤ 1$.)
# 

# 
# **Problem 3.2** Use the bound
# to write a function `exp_bound` which computes ${\rm e}^x$ with rigorous error bounds, that is
# so that when applied to an interval $[a,b]$ it returns an interval that is 
# guaranteed to contain the interval $[{\rm e}^a, {\rm e}^b]$.


function exp_bound(x::Interval, n)
    ## TODO: Return an Interval such that exp(x) is guaranteed to be a subset
    
end

e_int = exp_bound(Interval(1.0,1.0), 20)
@test_broken exp(big(1)) in e_int
@test_broken exp(big(-1)) in exp_bound(Interval(-1.0,-1.0), 20)
@test_broken e_int.b - e_int.a ≤ 1E-13 # we want our bounds to be sharp

# ------
# **Problem 4** Use `big` and `setprecision` to compute ℯ to a 1000 decimal digits with
# rigorous error bounds. 

# Hint: The function `big` will create a `BigFloat` version of a `Float64` and the type
# `BigFloat` allows changing the number of signficand bits. In particular, the code block
# ```julia
# setprecision(NUMSIGBITS) do
#
# end
# ```
# will use the number of significand bits specified by `NUMSIGBITS` for any `BigFloat` created
# between the `do` and the `end`. 

