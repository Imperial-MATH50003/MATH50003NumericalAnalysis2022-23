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
# a subset of the output. E.g. we can do $ℯ = exp(1) ∈ exp([1,1]) ⊆ exp^{FP}([1,1])
# where $exp^{FP}$ is implemented using $⊕$ and $⊗$.
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
# **Problem 5.1⋆** For intervals $A = [a,b]$ and $B = [c,d]$ such that $0 ∉ A,B$
#  and integer $n ≠ 0$, 
# deduce formulas for the minimum and maximum of $A/n$, $A+B$ and $AB$.
# -----
# **Problem 5.2** 
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
# Use the formulae from Problem 5.1 to complete (by replacing the `# TODO: …` comments with code)
#  the following implementation of an 
# `Interval` 
# so that `+`, `-`, and `/` implement $⊕$, $⊖$, and $⊘$ as defined above.

## Interval(a,b) represents the closed interval [a,b]
## We use templating so that T can be e.g. a `BigFloat`
struct Interval{T}
    a::T
    b::T
end

## We will overload *, +, -, / to use interval arithmetic.
## We also need to support `one` and `in`
import Base: *, +, -, /, one, in

## create an interval corresponding to [1,1]
one(x::Interval) = Interval(one(x.a), one(x.b))

## Support x in Interval(a,b)
in(x, y::Interval) = y.a ≤ x ≤ y.b

## Following should implement ⊕
function +(x::Interval, y::Interval)
    T = promote_type(typeof(x.a), typeof(x.b))
    a = setrounding(T, RoundDown) do
        ## TODO: lower bound
        x.a + y.a
    end
    b = setrounding(T, RoundUp) do
        ## TODO: upper bound
        x.b + y.b
    end
    Interval(a, b)
end

## following example was the non-associative example but now we have bounds
@test Interval(1.1,1.1) + Interval(1.2,1.2) + Interval(1.3,1.3) ≡ Interval(3.5999999999999996, 3.6000000000000005)

## Following should implement ⊘
function /(x::Interval, n::Integer)
    T = typeof(x.a)
    if iszero(n)
        error("Dividing by zero not support")
    end
    a = setrounding(T, RoundDown) do
        ## TODO: lower bound
        ## SOLUTION
        if n > 0
            x.a / n
        else
            x.b / n
        end
        ## END
    end
    b = setrounding(T, RoundUp) do
        ## TODO: upper bound
        ## SOLUTION
        if n > 0
            x.b / n
        else
            x.a / n
        end
        ## END
    end
    Interval(a, b)
end

@test Interval(1.0,2.0)/3 ≡ Interval(0.3333333333333333, 0.6666666666666667)
@test Interval(1.0,2.0)/(-3) ≡ Interval(-0.6666666666666667, -0.3333333333333333)

## Following should implement ⊗
function *(x::Interval, y::Interval)
    T = promote_type(typeof(x.a), typeof(x.b))
    if 0 in x || 0 in y
        error("Multiplying with intervals containing 0 not supported.")
    end
    a = setrounding(T, RoundDown) do
        ## TODO: lower bound
        ## SOLUTION
        if x.a < 0 && x.b < 0 && y.a < 0 && y.b < 0
            y.b * x.b
        elseif x.a < 0 && x.b < 0 && y.a > 0 && y.b > 0
            x.a * y.b
        elseif x.a > 0 && x.b > 0 && y.a < 0 && y.b < 0
            x.b * y.a
        else
            x.a * y.a
        end
        ## END
    end
    b = setrounding(T, RoundUp) do
        ## TODO: upper bound
        ## SOLUTION
        if x.a < 0 && x.b < 0 && y.a < 0 && y.b < 0
            y.a * x.a
        elseif x.a < 0 && x.b < 0 && y.a > 0 && y.b > 0
            x.b * y.a
        elseif x.a > 0 && x.b > 0 && y.a < 0 && y.b < 0
            x.a * y.b
        else
            x.b * y.b
        end
        ## END
    end
    Interval(a, b)
end

@test Interval(1.1, 1.2) * Interval(2.1, 3.1) ≡ Interval(2.31, 3.72)
@test Interval(-1.1, -1.2) * Interval(2.1, 3.1) ≡ Interval(-3.4100000000000006, -2.5199999999999996)
@test Interval(1.1, 1.2) * Interval(-2.1, -3.1) ≡ Interval(-2.52, -3.41)
@test Interval(-1.1, -1.2) * Interval(-2.1, -3.1) ≡ Interval(3.7199999999999998, 2.3100000000000005)

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

# -----

# **Problem 5.3⋆** Bound the tail of the Taylor series for ${\rm e}^x$ assuming $|x| ≤ 1$. 
# (Hint: ${\rm e}^x ≤ 3$ for $x ≤ 1$.)
# **SOLUTION** From the Taylor remainder theorem we know the error is
# $$
# {f^{(k+1)}(ξ) \over (k+1)!} |x|^{k+1} \leq {3 \over (k+1)!}
# $$
# Thus by widening the computation by this error we ensure that we have
# captured the error by truncating the Taylor series.

# ------
# 
# **Problem 5.4** Use the bound
# to write a function `exp_bound` which computes ${\rm e}^x$ with rigorous error bounds, that is
# so that when applied to an interval $[a,b]$ it returns an interval that is 
# guaranteed to contain the interval $[{\rm e}^a, {\rm e}^b]$.
##

## SOLUTION
function exp_bound(x::Interval, n)
    ## TODO: Return an Interval such that exp(x) is guaranteed to be a subset
    if abs(x.a) > 1 || abs(x.b) > 1
        error("Interval must be a subset of [-1, 1]")
    end
    ret = exp_t(x, n) # the code for Taylor series should work on Interval unmodified
    f = factorial(min(20, n + 1)) # avoid overflow in computing factorial
    T = typeof(ret.a)

    err = setrounding(T, RoundUp) do
        3 / f
    end
    ret + Interval(-err,err)
    ## END
end

e_int = exp_bound(Interval(1.0,1.0), 20)
@test exp(big(1)) in e_int
@test exp(big(-1)) in exp_bound(Interval(-1.0,-1.0), 20)
@test e_int.b - e_int.a ≤ 1E-13 # we want our bounds to be sharp

# ------
# **Problem 5.5** Use `big` and `setprecision` to compute ℯ to a 1000 decimal digits with
# rigorous error bounds. 

##
## SOLUTION

setprecision(100_000) do
    exp_bound(Interval(big(1.0),big(1.0)), 20)
end

## END