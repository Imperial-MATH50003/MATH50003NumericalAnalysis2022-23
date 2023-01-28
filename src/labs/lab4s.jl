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