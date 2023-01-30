
## 4. Permutations

**Problem 4.1⋆ (C)** What are the permutation matrices corresponding to the following permutations?
$$
\begin{pmatrix}
1 & 2 & 3 \\
3 & 2 & 1
\end{pmatrix}, \begin{pmatrix}
1 & 2 & 3 & 4 & 5 & 6\\
2 & 1 & 4 & 3 & 6 & 5
\end{pmatrix}.
$$

**SOLUTION**

Let $\sigma=\begin{pmatrix}1 & 2 & 3 \\ 3 & 2 & 1\end{pmatrix}$ and $\tau=\begin{pmatrix}1 & 2 & 3 & 4 & 5 & 6\\ 2 & 1 & 4 & 3 & 6 & 5\end{pmatrix}$. There are two ways to construct $P_\sigma$ and $P_\tau$.

- Column by column:
  $$P_\sigma=
  \left(\mathbf{e}_{\sigma_1^{-1}}\middle|\mathbf{e}_{\sigma_2^{-1}}\middle|\mathbf{e}_{\sigma_3^{-1}}\right)=
  \left(\mathbf{e}_3\middle|\mathbf{e}_2\middle|\mathbf{e}_1\right)$$
  $$P_\tau=
  \left(\mathbf{e}_{\tau_1^{-1}}\middle|\mathbf{e}_{\tau_2^{-1}}\middle|\mathbf{e}_{\tau_3^{-1}}\middle|\mathbf{e}_{\tau_4^{-1}}\middle|\mathbf{e}_{\tau_5^{-1}}\middle|\mathbf{e}_{\tau_6^{-1}}\right)=
  \left(\mathbf{e}_2\middle|\mathbf{e}_1\middle|\mathbf{e}_4\middle|\mathbf{e}_3\middle|\mathbf{e}_6\middle|\mathbf{e}_5\right)$$
- Row by row:
  $$P_\sigma=I[\mathbf{\sigma},:]=
  \begin{pmatrix}
  I[\sigma_1,:]\\
  I[\sigma_2,:]\\
  I[\sigma_3,:]
  \end{pmatrix}=
  \begin{pmatrix}
  I[3,:]\\
  I[2,:]\\
  I[1,:]
  \end{pmatrix}$$
  $$P_\tau=I[\mathbf{\tau},:]=
  \begin{pmatrix}
  I[\tau_1,:]\\
  I[\tau_2,:]\\
  I[\tau_3,:]\\
  I[\tau_4,:]\\
  I[\tau_5,:]\\
  I[\tau_6,:]\\
  \end{pmatrix}=
  \begin{pmatrix}
  I[2,:]\\
  I[1,:]\\
  I[4,:]\\
  I[3,:]\\
  I[6,:]\\
  I[5,:]\\
  \end{pmatrix}$$

Either way, we have
$$P_\sigma=
\begin{pmatrix}
0 & 0 & 1\\ 
0 & 1 & 0\\ 
1 & 0 & 0
\end{pmatrix}
\qquad\text{and}\qquad
P_\tau=
\begin{pmatrix}
0 & 1 & 0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0 & 1 & 0
\end{pmatrix}$$

**Problem 4.2 (B)** Complete the implementation of a type representing
permutation matrices that supports `P[k,j]` and such that `*` takes $O(n)$ operations.
```julia
using LinearAlgebra, Test

struct PermutationMatrix <: AbstractMatrix{Int}
    p::Vector{Int} # represents the permutation whose action is v[p]
    function PermutationMatrix(p::Vector)
        sort(p) == 1:length(p) || error("input is not a valid permutation")
        new(p)
    end
end

function size(P::PermutationMatrix)
    (length(P.p),length(P.p))
end
function getindex(P::PermutationMatrix, k::Int, j::Int)
    # P.p[k] == j ? 1 : 0 
    if P.p[k] == j
        1
    else 
        0
    end
end
function *(P::PermutationMatrix, x::AbstractVector)
    x[P.p]
end

# If your code is correct, this "unit test" will succeed
p = [1, 4, 2, 5, 3]
P = PermutationMatrix(p)
@test P == I(5)[p,:]
```

The following codes show that `*` takes $O(n)$ of both time and space.
```julia
using BenchmarkTools, Random
x=0 # for some reason, an error "UndefVarError: x not defined" will occur without this line. p and P are previously defined so they work fine.
for n = 10 .^ (1:7)
    print("n = ", n)
    p = randperm(n)
    P = PermutationMatrix(p)
    x = randn(n)
    @btime P*x
end
```

## 5. Orthogonal matrices

**Problem 5.1⋆ (C)** Show that orthogonal matrices preserve the 2-norm of vectors:
$$
\|Q 𝐯\| = \|𝐯\|.
$$

**SOLUTION**
$$
\|Q 𝐯\|^2 = (Q 𝐯)^⊤ Q 𝐯 = 𝐯^⊤ Q^⊤ Q 𝐯 = 𝐯^⊤  𝐯 = \|𝐯\|^2
$$
∎

**Problem 5.2⋆ (B)** Show that the eigenvalues $λ$ of an orthogonal matrix $Q$ are
on the unit circle: $|λ| = 1$.

**SOLUTION**
Let $𝐯$ be a unit eigenvector corresponding to $λ$: $Q 𝐯 = λ 𝐯$ with $\|𝐯\| = 1$. Then
$$
1 = \| 𝐯 \| = \|Q 𝐯 \| =  \| λ 𝐯 \| = |λ|.
$$
∎

**Problem 5.3⋆ (A)** Explain why an orthogonal matrix $Q$ must be equal to $I$ if all its eigenvalues are 1.

**SOLUTION**

Note that $Q$ is normal ($Q^⊤ Q = I$) and therefore by the spectral theorem for 
normal matrices we have
$$
Q = Q̃ Λ Q̃^⋆ = Q̃ Q̃^⋆ = I
$$
since $Q̃$ is unitary. 

**Problem 5.4 (B)** Complete the implementation of a type representing
reflections that supports `Q[k,j]` and such that `*` takes $O(n)$ operations.
```julia
using LinearAlgebra, Test

# Represents I - 2v*v'
struct Reflection{T} <: AbstractMatrix{T}
    v::Vector{T}
end

Reflection(x::Vector{T}) where T = Reflection{T}(x/norm(x))

function size(Q::Reflection)
    (length(Q.v),length(Q.v))
end
function getindex(Q::Reflection, k::Int, j::Int)
    (k == j) - 2Q.v[k]*Q.v[j] # note true is treated like 1 and false like 0
end
function *(Q::Reflection, x::AbstractVector)
    x - 2*Q.v * dot(Q.v,x) # (Q.v'*x) also works instead of dot
end

# If your code is correct, these "unit tests" will succeed
x = randn(5)
Q = Reflection(x)
v = x/norm(x)
@test Q == I-2v*v'
@test Q*v ≈ -v
@test Q'Q ≈ I
```

The following codes show that `*` takes $O(n)$ of both time and space.
```julia
using BenchmarkTools, Random
for n = 10 .^ (1:7)
    print("n = ", n)
    x = randn(n)
    Q = Reflection(x)
    v = randn(n)
    @btime Q*v
end
```

**Problem 5.5 (C)** Complete the following implementation of a Housholder reflection  so that the
unit tests pass. Here `s == true` means the Householder reflection is sent to the positive axis and `s == false` is the negative axis.

```julia
function householderreflection(s::Bool, x::AbstractVector)
    y = copy(x) # don't modify `x`
    if s
        y[1] -= norm(x)
    else
        y[1] += norm(x)
    end
    Reflection(y)
end

x = randn(5)
Q = householderreflection(true, x)
@test Q isa Reflection
@test Q*x ≈ [norm(x);zeros(eltype(x),length(x)-1)]

Q = householderreflection(false, x)
@test Q isa Reflection
@test Q*x ≈ [-norm(x);zeros(eltype(x),length(x)-1)]
```

**Problem 5.6⋆ (A)** Consider a Householder reflection with $𝐱 = [1,h]$
with $h = 2^{-n}$. What is the floating point error in
computing $𝐲 = ∓ \|𝐱\| 𝐞_1 + 𝐱$ for each choice of sign.

**SOLUTION**

Since $\|𝐱\|=\sqrt{1+h^2}$, we have $𝐲=[1∓\sqrt{1+h^2},h]$. We note first that $h^{fp}$ and $(h^2)^{fp}$ are exact due to the choice of $h$, so we only need to discuss the floating error in computing $1\mp\sqrt{1+h^2}$.

Numerically, let the length of the significand be $S$, then
$$
1\oplus h^2=
\begin{cases}
1+h^2 & n\le S/2 \\
1 & n>S/2
\end{cases}
=1+h^2+\delta_1
$$
where $|\delta_1|\le \frac{\epsilon_m}{2}$.

$+$ PLUS $+$

Since $\sqrt{1\oplus h^2}^{fp}>0$, we know that
$$\begin{split}
1\oplus\sqrt{1\oplus h^2}^{fp}=&(1+\delta_2)(1+\sqrt{1\oplus h^2}^{fp})\\
=&(1+\delta_2)(1+\sqrt{1+h^2+\delta_1}(1+\delta_3))
\end{split}$$
where $|\delta_2|,|\delta_3|\le \frac{\epsilon_m}{2}$. Then
$$\begin{split}
\frac{1\oplus\sqrt{1\oplus h^2}^{fp}}{1+\sqrt{1+h^2}}=&(1+\delta_2)\left(1+\frac{\sqrt{1+h^2+\delta_1}(1+\delta_3)-\sqrt{1+h^2}}{1+\sqrt{1+h^2}}\right)\\
=&(1+\delta_2)\left(1+\frac{(1+\delta_3)(\sqrt{1+h^2+\delta_1}-\sqrt{1+h^2})+\delta_3\sqrt{1+h^2}}{1+\sqrt{1+h^2}}\right)\\
\approx &(1+\delta_2)\left(1+\frac{\delta_1}{2(1+\sqrt{1+h^2})\sqrt{1+h^2}}+\delta_3\frac{\sqrt{1+h^2}}{1+\sqrt{1+h^2}}\right)
\end{split}$$
and we can bound the relative error by
$$|\delta_2|+|\delta_1|\frac{1}{2(1+\sqrt{1+h^2})\sqrt{1+h^2}}+|\delta_3|\frac{\sqrt{1+h^2}}{1+\sqrt{1+h^2}}\le |\delta_2|+\frac{|\delta_1|}{4}+\frac{3|\delta_3|}{4}\le \epsilon_m.$$

In conclusion, it's very accurate to compute $1+\sqrt{1+h^2}$. Let us verify this:
```julia
using Plots
S = precision(Float64)-1;
relative_error = zeros(S)
for n = 1:S
    h = 2.0^(-n)
    exact = 1+sqrt(1+BigFloat(h)^2)
    numerical = 1+sqrt(1+h^2)
    relative_error[n] = abs(numerical-exact)/exact
end
println(eps())
maximum(relative_error)
```

$-$ MINUS $-$

If $n>S/2$, then $1\ominus\sqrt{1\oplus h^2}^{fp}=1\ominus\sqrt{1}^{fp}=1\ominus 1=0$ so the relative error is 100%.

If $n\le S/2$ but not too small, $1\oplus h^2$ is exactly $1+h^2$ but $\sqrt{1+h^2}^{fp}$ can have rounding error. Expand $\sqrt{1+h^2}$ into Taylor series:
$$\sqrt{1+h^2}=1+\frac{1}{2}h^2-\frac{1}{8}h^4+\frac{1}{16}h^6-O(h^8)=1+2^{-2n-1}-2^{-4n-3}+2^{-6n-4}-O(2^{-8n})$$
so
$$\sqrt{1+h^2}^{fp}=
\begin{cases}
1 & n=S/2\\
1+\frac{1}{2}h^2 & \frac{S-3}{4}\le n<S/2\\
1+\frac{1}{2}h^2-\frac{1}{8}h^4 & \frac{S-4}{6}\le n<\frac{S-3}{4}\\
\vdots & \vdots
\end{cases}$$
where we can conclude that the absolute error is approximately $\frac{1}{2}h^2,\frac{1}{8}h^4,\frac{1}{16}h^6,\dots$ for each stage when $h$ is small. Keeping in mind that $1-\sqrt{1+h^2}\approx -\frac{1}{2}h^2$ when $h$ is small, the relative error is approximately $1, \frac{1}{4}h^2,\frac{1}{8}h^4,\dots$ for each stage. Special note: the relative error is exactly 1 in the first stage when $n=S/2$.

If $n$ is so small that $\sqrt{1+h^2}$ is noticably larger than 1, the absolute error can be bounded by $\frac{\epsilon_m}{2}$ so the relative error is bounded by $\frac{\epsilon_m}{2(\sqrt{1+h^2}-1)}\approx \frac{\epsilon_m}{h^2}$.

Let us verify these conclusions:
```julia
using Plots
S=precision(Float64)-1;
relative_error=zeros(S)
for n=1:S
    h=2.0^(-n)
    exact=1-sqrt(1+BigFloat(h)^2)
    numerical=1-sqrt(1+h^2)
    relative_error[n]=-abs(numerical-exact)/exact
end
plot(1:S,log2.(relative_error), xlabel="n", ylabel="relative error (log2)")
```

From this plot we can clearly identify the 3 phases:
1. When $n$ is very small, the relative error grows smoothly with $n$;
2. When $n$ is neither too large nor too small, the relative error has jumps at around $S/2=26$, $(S-3)/4=12.25$, $(S-4)/6=8$. In each stage, the slope is as predicted. For example, the first stage from $S/2$ to $(S-3)/4$ has relative error of $\frac{1}{4}h^2$, hence the slope is -2 between 13 and 25.
3. When $n\ge S/2$, the relative error is 100%;

The transition point between phase 1 and 2 is at the stage for $O(h^8)$ of relative error from phase 2 which meets $\frac{\epsilon_m}{h^2}$ from phase 1.
