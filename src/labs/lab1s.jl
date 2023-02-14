# # MATH50003 (2022–23)
# # Lab 1: Introduction to Julia

# This problem sheet is designed to introduce some basic Julia
# knowledge. Note each problem has multiple solutions, and the solution
# sheet will show different ways of solving the same problem. We will discuss the
# following:

# 1. Integers
# 2. Reals
# 2. Strings and parsing
# 3. Types

# In assessment, _any_ "solution" will be accepted provided it does the right thing!
# So you do not need to be able to write broadcasting or comprehensions
# if you can do for loops.

# We load the following packages:

using ColorBitstring, Test

# ## 1. Integers

# Every primitive number type is stored as a sequence of bits. 
# The number of _bytes_ (i.e. 8-bits) can be deduced using the `sizeof` function:

sizeof(UInt32) # 4 bytes == 4*8 bits == 32 bits

# The function `typeof` can be used to determine the type of a number.
# By default when we write an integer (e.g. `-123`) it is of type `Int`:

typeof(5)

# -----
# **Problem 1.1** Use `sizeof` to determine how many bits your machine uses for the type `Int`.

## SOLUTION

sizeof(Int) # returns 8 bytes == 8*8 bits = 64 bits. Some machines may be 32 bits.

## END

# -----

# There are a few ways to create other types of integers. Conversion
# converts between different types:

UInt8(5) # converts an `Int` to an `UInt8`, displaying the result in hex

# This fails if a number cannot be represented as a specified type: e.g. `UInt8(-5)` and `UInt8(2^8)`.

# (These can also be written as e.g. `convert(UInt8, 5)`.)
# We can also create unsigned integers by specifying their bits
# by writing `0b` followed by a sequence of bits:

0b101 # isa UInt8, the smallest type with at least 3 bits
#
0b10111011101 # isa UInt16, the smallest type with at least 11 bits

# Or in base-16 using hexadecimal format (with digits `0–9a–f` following
# an `0x`), where each digit takes 4 bits to represent (since $2^4 = 16$):

0xabcde # isa UInt32, the smallest type with at least 4*5 = 20 bits

# -----
# **Problem 1.2** Use binary format to create an `Int` corresponding to $(101101)_2$.

## SOLUTION

Int(0b101101) # Without the `Int` it would be a UInt8

## END


# -----

# **Problem 1.3** What happens if you specify more than 64 bits using `0b⋅⋅…⋅⋅`? 
# What if you specify more than 128 bits?

## SOLUTION

typeof(0b111111111111111111111111111111111111111111111111111111111111111111111111111111111111) # creates a UInt128

typeof(0b111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111) # creates a BigInt

## END

# -----

# We can also reinterpret a sequence of bits in a different format:

reinterpret(Int8, 0b11111111) # Create an Int8 with the bits 11111111



# Arithmetic follows modular arithmetic. The following examples test your understanding of this.

# -----

# **Problem 1.5** Can you predict what the output of the following will be before hitting return?

UInt8(120) + UInt8(10); # Convert to `Int` to see the number printed in decimal
#
Int8(120) + Int8(10);
#
UInt8(2)^7;
#
Int8(2)^7;
#
Int8(2)^8;
#

## SOLUTION

UInt8(120) + UInt8(10) # returns 0x82 = 8*16+2 = 130

Int8(120) + Int8(10) # returns -126 since mod(-126,2^8) == 130

UInt8(2)^7 # Returns 0x80 = 8*16 = 128

Int8(2)^7 # Retuns -128 since mod(-128,2^8) == 128

Int8(2)^8 # Returns 0 since mod(2^8, 2^8) == 0

## END

# -----

# ## 2. Reals
# 
# Real numbers interpret a sequence of bits in floating point format. 
# 
# -----
# **Problem 2.1** Use `printbits` to guess the binary representation of $1/5$.

## SOLUTION

printbits(1/5) 
## exponent is 0b01111111100 == 1020 so we have 2^(1020 - 1023) = 2^(-3)
## significand is 1.1001100110011001100110011001100110011001100110011010
## guess: 1/5 == 2^(-3) (1.10011001100…)_2 2^(-3) (∑_{k=0}^∞ (2^(-4k) + 2^(-4k-1)))

## END

# -----

# **Problem 2.2** Create a positive `Float64` whose exponent is $q = 156$ and has significand
# bits
# $$
# b_k = \begin{cases}
#     1 & k\hbox{ is prime} \\
#     0 & \hbox{otherwise}
#     \end{cases}
# $$

## SOLUTION

## significand has 52 bits. we can either do it by hand or create a string:

function isprime(k) # quick-and-dirty test for prime
    if k ≤ 1
        return false
    end
    for j=1:k-1
        if gcd(k, j) ≠ 1
            return false
        end
    end
    return true
end

ret = "1" # leading coefficient

for k = 1:52
    global ret # in scripts we need to let Julia know ret is a global variable
    if isprime(k)
        ret *= "1"
    else
        ret *= "0"
    end
end

sig = 2.0^(-52) * parse(Int, ret; base=2)

2.0^(156 - 1023) * sig

## END

# -----

# **Problem 2.3** Create the smallest positive non-zero sub-normal `Float16` by specifying
# its bits.

## SOLUTION
## sign is + so sign bit is 0, exponent is 00000 and significand is all zeros apart from a 1:
reinterpret(Float16, 0b0000000000000001) # == nextfloat(Float16(0))
## END

# -----

# ## 3. Strings and parsing

# Strings are a convenient way of representing arbitrary strings of digits.
# For example we can convert bits of a number to a string of "1"s and "0"s using the function `bitstring`.

# -----

# **Problem 3.1** Can you predict what the output of the following will be before hitting return?

bitstring(11);  # Semi-colon prohibits output, delete to check your answer
#
bitstring(-11);

## SOLUTION
bitstring(11) # "0000000000000000000000000000000000000000000000000000000000001011"
bitstring(-11) # "1111111111111111111111111111111111111111111111111111111111110101"
## this is because mod(-11, 2^64) == 2^64 - 12 == 0b10000…000 - 0b1100 == 0b111…11 - 0b1011 + 0b1
## END

# -----

# We can `parse` a string of digits in base 2 or 10:

parse(Int8, "11"; base=2), 
parse(Int8, "00001011"; base=2)

# Be careful with "negative" numbers, the following will fail: `parse(Int8, "10001011"; base=2)`

# It treats the string as binary digits, NOT bits. That is, negative numbers
# are represented using the minus sign:

parse(Int8, "-00001011"; base=2)

# -----

# **Problem 3.2** Combine `parse`, `reinterpret`, and `UInt8` to convert the
# above string to a (negative) `Int8` with the specified bits.

## SOLUTION

## The above code creates the bits "11110101". Instead, we first parse the bits:

x = reinterpret(Int8, parse(UInt8, "10001011"; base=2)) # -117
bitstring(x)

## END

# -----

# To concatenate strings we use `*` (multiplication is used because string concatenation
# is non-commutative):

"hi" * "bye"

# The string consisting of the first nine characters can be found using `str[1:9]` where `str` is any string:

str="hibye0123445556"
str[1:9]  # returns "hibye0123"

# The string consisting of the 11th through last character can be found using `str[11:end]`:

str="hibye0123445556"
str[11:end]  # returns "45556"

# -----

# **Problem 3.3** Complete the following function that sets the 10th bit of an `Int32` to `1`,
# and returns an `Int32`, assuming that the input is a positive integer, using `bitstring`,
# `parse` and `*`.

function tenthbitto1(x::Int32)
    ## TODO: change the 10th bit of `x` to 1
end

## unit tests are to help you check your result
## Change to `@test` to see if your test passes
@test_broken tenthbitto1(Int32(100)) ≡ Int32(4194404)

## SOLUTION
function tenthbitto1(x::Int32)
    ## TODO: change the 10th bit of `x` to 1
    ret = bitstring(x)
    parse(Int32, ret[1:9] * "1" * ret[11:end]; base=2)
end

## unit tests are to help you check your result
## Change to `@test` to see if your test passes
@test tenthbitto1(Int32(100)) ≡ Int32(4194404)

## END

# -----


# **Problem 3.4**  Modify the previous function to also work with negative numbers. 

function tenthbitto1(x::Int32)
## TODO: change the 10th bit of `x` to 1
end

@test_broken tenthbitto1(Int32(100)) ≡ Int32(4194404)
@test_broken tenthbitto1(-Int32(100000010)) ≡ Int32(-95805706)

## SOLUTION

function tenthbitto1(x::Int32)
    ## TODO: change the 10th bit of `x` to 1
    ret = bitstring(x)
    x = parse(UInt32, ret[1:9] * "1" * ret[11:end]; base=2)
    reinterpret(Int32, x)
end

@test tenthbitto1(Int32(100)) ≡ Int32(4194404)
@test tenthbitto1(-Int32(100000010)) ≡ Int32(-95805706)

## END

# -----

# ## 4. Types

# Types allow for combining multiple numbers (or other types) to represent a more complicated
# object. That is, while a computer can only apply functions on $p$-bits at a time,
# these functions can be combined to perform more complicated operations on types
# that require more than $p$-bits. A simple example is a rational function.

# -----

# **Problem 4.1** Create a type `Rat` with two `Int` fields, `p` and `q`,
# representing a rational function including `+`, `*`, `-`, and `/`.


## `struct` creates a new type called `Rat`
## consisting of 128 bits, half encode `p`
## and half encode `q`
struct Rat
    p::Int
    q::Int
end

## A new instance of `Rat` is created via e.g. `Rat(1, 2)` represents 1/2
## where the first argument specifies `p` and the second argument `q`.
## The fields are accessed by `.`:

x = Rat(1, 2)
@test x.p == 1
@test x.q == 2

## We import `+`, `-`, `*`, `/` so we can "overload" these operations specifically
## for `Rat`.
import Base: +, -, *, /, ==


## The ::Rat means the following version of `==` is only called if both arguments
## are Rat
function ==(x::Rat, y::Rat)
    ## TODO: implement equality, making sure to check the case where
    ## the numerator/denominator are possibly reducible
    ## Hint: `gcd` and `div` may be useful. Use `?` to find out what they do

    ## SOLUTION
    xg = gcd(x.p, x.q)
    yg = gcd(y.p, y.q)
    div(x.p, xg) == div(y.p, yg) && div(x.q, xg) == div(y.q, yg)
    ## END
end

## We can also support equality when `x isa Rat` and `y isa Integer`
function ==(x::Rat, y::Integer)
    ## TODO: implement
    ## SOLUTION
    x == Rat(y, 1)
    ## END
end

## TODO: implement ==(x::Integer, y::Rat)
## SOLUTION
function ==(x::Integer, y::Rat)
    ## TODO: implement
    ## SOLUTION
    Rat(x,1) == y
    ## END
end

## END

@test Rat(1, 2) == Rat(2, 4)
@test Rat(1, 2) ≠ Rat(1, 3)
@test Rat(2,2) == 1
@test 1 == Rat(2,2)

## TODO: implement +, -, *, and /, 
## SOLUTION

+(x::Rat, y::Rat) = Rat(x.p * y.q + y.p * x.q, x.q * y.q)
-(x::Rat, y::Rat) = Rat(x.p * y.q - y.p * x.q, x.q * y.q)
*(x::Rat, y::Rat) = Rat(x.p * y.p, x.q * y.q)
/(x::Rat, y::Rat) = x * Rat(y.q, y.p)

## END

@test Rat(1, 2) + Rat(1, 3) == Rat(5, 6)
@test Rat(1, 3) - Rat(1, 2) == Rat(-1, 6)
@test Rat(2, 3) * Rat(3, 4) == Rat(1, 2)
@test Rat(2, 3) / Rat(3, 4) == Rat(8, 9)

# ---------

# Templating is a way of letting fields take on different types. For example, the following
# code allows `x` to be any type:

struct Foo{T}
    x::T
end

Foo(5) # isa Foo{Int}
#
Foo("hi") # isa Foo{String}

# -----


# **Problem 4.2** Modify the above code so that `p` and `q` can be other types but both the same type,
# for example, `Int16` or `BigInt`.

## SOLUTION
## Unfortunately we can't name our new type Rat again so I'll call it RatTemplated.
## The rest of the cidode is the same.
struct RatTemplated{T}
    p::T
    q::T
end

function ==(x::RatTemplated, y::RatTemplated)
    xg = gcd(x.p, x.q)
    yg = gcd(y.p, y.q)
    div(x.p, xg) == div(y.p, yg) && div(x.q, xg) == div(y.q, yg)
end

==(x::RatTemplated, y::Integer) = x == RatTemplated(y, 1)
==(x::Integer, y::RatTemplated) = RatTemplated(x,1) == y

+(x::RatTemplated, y::RatTemplated) = RatTemplated(x.p * y.q + y.p * x.q, x.q * y.q)
-(x::RatTemplated, y::RatTemplated) = RatTemplated(x.p * y.q - y.p * x.q, x.q * y.q)
*(x::RatTemplated, y::RatTemplated) = RatTemplated(x.p * y.p, x.q * y.q)
/(x::RatTemplated, y::RatTemplated) = x * RatTemplated(y.q, y.p)


## END

@test RatTemplated(big(2)^64, big(2)^65) == RatTemplated(1, 2)
