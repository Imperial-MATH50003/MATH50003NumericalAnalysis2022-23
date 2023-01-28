## 3. Newton iteration

Newton iteration is an algorithm for computed roots of a function $f$ using its derivative: given an initial guess $x_0$, one
obtains a sequence of guesses via
$$
x_{k+1} = x_k - {f(x_k) \over f'(x_k)}
$$

**Problem 3.1 (B)** Use `Dual` to implement the following function which returns $x_n$:
```julia
function newton(f, x0, n)
    ## TODO: compute x_n 
    ## SOLUTION
    xk = x0
    for k = 1:n
        fd = f(xk + ϵ)
        xk = xk - fd.a / fd.b
    end
    return xk
    ## END
end
```

**SOLUTION**

Here is a simple test case for the above function:
```julia
# example
f_ex(x) = x^2-3
n = 5
x0 = 1
# compute proposed root
xn = newton(f_ex,x0,n) 
# check that obtained point is an approximate root
f_ex(xn)
```

**END**


**Problem 3.2 (B)** Compute points $y$ such that $|f(y)| \leq 10^{-13}$ (i.e., approximate roots):
$$
\exp(\exp x \cos x + \sin x)-6\hbox{ and } \prod_{k=1}^{1000} \left({x \over k}-1\right) - {1 \over 2}
$$
(Hint: you may need to try different `x0` and `n` to get convergence. Plotting the function should give an
indication of a good initial guess.)

**SOLUTION**

We can plot the functions on a few ranges to get an intuition
```julia
using Plots

f1(x) = exp(exp(x)*cos(x) + sin(x)) - 6
f2(x) = prod([x] ./ range(1,1000) .- 1) - 1/2

plot(f1,-2,2,color="blue")
plot!(x->0,color="red")
```
```julia
plot(f2,0,2,color="blue")
plot!(x->0,color="red") 
```
And then use our Newton iteration to compute approximate roots
```julia
rootf1 = newton(f1, 1.5, 5)
f1(rootf1)
```
```julia
rootf2 = newton(f2, 0.3, 8)
f2(rootf2)
```

**Problem 3.3 (A)** Compute points $y$ such that $|f^{\rm s}_{1000}(y) - j| \leq 10^{-13}$ for $j = 1,2,3$. 
Make a conjecture of what $f^{\rm s}_n(x)$ converges to as $n → ∞$. (Bonus problem: Prove your conjecture.)

**SOLUTION**

```julia
xn = newton(x->cont(1000,x)-1.,0.5,10)
cont(1000,xn)-1.
```
```julia
xn = newton(x->cont(1000,x)-2.,0.5,10)
cont(1000,xn)-2.
```
```julia
xn = newton(x->cont(1000,x)-3.,0.5,10)
cont(1000,xn)-3.
```

By plotting the function we can conjecture that the continued fraction converges to $\sqrt{x}$:
```julia
using Plots
plot(x->cont(1000,x),0,10)
plot!(x->sqrt(x))
```
There are a handful of ways to prove this conjecture. Here is one - start with

$$ \sqrt{x}(1+\sqrt{x}) = \sqrt{x}+x,$$

then extend the RHS by $0 = +1-1$ to also obtain the factor $1+\sqrt{x}$ there, resulting in

$$ \sqrt{x}(1+\sqrt{x}) = (1+\sqrt{x})+x-1.$$

Dividing through $(1+\sqrt{x})$ now yields

$$ \sqrt{x} = 1 + \frac{x-1}{1+\sqrt{x}}.$$

Note that we can now plug this equation into itself on the right hand side to obtain a recursive continued fraction for the square root function.
