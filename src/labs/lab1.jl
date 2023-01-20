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

##
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

##

# -----

# **Problem 1.3** What happens if you specify more than 64 bits using `0b⋅⋅…⋅⋅`? 
# What if you specify more than 128 bits?

##

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

# -----

# ## 2. Reals
# 
# Real numbers interpret a sequence of bits in floating point format. 
# 
# -----
# **Problem 2.1** Use `printbits` to guess the binary representation of $1/5$.

##

# -----

# **Problem 2.2** Create a positive `Float16` whose exponent is $q = 156$ and has significand
# bits
# $$
# b_k = \begin{cases}
#     1 & k\hbox{ is prime} \\
#     0 & \hbox{otherwise}
#     \end{cases}
# $$

##

# -----

# **Problem 2.3** Create the smallest postive non-zero sub-normal `Float16` by specifying
# its bits.

##

# -----

# ## 3. Strings and parsing

# Strings are a convenient way of representing arbitrary strings of digits.
# For example we can convert bits of a number to a string of "1"s and "0"s using the function `bitstring`.

# -----

# **Problem 3.1** Can you predict what the output of the following will be before hitting return?

bitstring(11);  # Semi-colon prohibits output, delete to check your answer
#
bitstring(-11);

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

##

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

# -----


# **Problem 3.4**  Modify the previous function to also work with negative numbers. 

function tenthbitto1(x::Int32)
## TODO: change the 10th bit of `x` to 1
end

@test_broken tenthbitto1(Int32(100)) ≡ Int32(4194404)
@test_broken tenthbitto1(-Int32(100000010)) ≡ Int32(-95805706)

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
end

## We can also support equality when `x isa Rat` and `y isa Integer`
function ==(x::Rat, y::Integer)
    1 # TODO: implement
end

## TODO: implement ==(x::Integer, y::Rat)

@test_broken Rat(1, 2) == Rat(2, 4)
@test_broken Rat(1, 2) ≠ Rat(1, 3)
@test_broken Rat(2,2) == 1
@test_broken 1 == Rat(2,2)

## TODO: implement +, -, *, and /, 

@test_broken Rat(1, 2) + Rat(1, 3) == Rat(5, 6)
@test_broken Rat(1, 3) - Rat(1, 2) == Rat(-1, 6)
@test_broken Rat(2, 3) * Rat(3, 4) == Rat(1, 2)
@test_broken Rat(2, 3) / Rat(3, 4) == Rat(8, 9)

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

##
