# MATH50003NumericalAnalysis (2022–2023)
Notes and course material for MATH50003 Numerical Analysis

Lecturer: [Dr Sheehan Olver](https://www.ma.imperial.ac.uk/~solver/)

Office hour: Mondays 11am, Huxley 6M40

## Notes ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/Notes.pdf))

*Background material*

  A. [Introduction to Julia](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/A.Julia.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/A.Julia.pdf)): we introduce  the basic features of the Julia language. \
  B. [Asymptotics and Computational Cost](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/B.Asymptotics.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/B.Asymptotics.pdf)): we review Big-O, little-o and asymptotic to notation,
and their usage in describing computational cost. \
  C. [Adjoints and Normal Matrices](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/C.Adjoints.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/C.Adjoints.pdf)): we review complex inner-products, adjoints, normal matrices, and the spectral theorem.

*I: Computing with numbers*

1. [Integers](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/I.1.Integers.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/I.1.Integers.pdf)): we discuss how computers represent integers using modular arithmetic.
2. [Reals](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/I.2.Reals.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/I.2.Reals.pdf)): we discuss how computers represent reals using IEEE floating-point arithmetic.
3. [Divided Differences](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/I.3.DividedDifferences.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/I.3.DividedDifferences.pdf)): we discuss how we can approximate derivatives using floating point arithmetic, with error bounds.
4. [Dual Numbers](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/I.4.DualNumbers.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/I.4.DualNumbers.pdf)): we discuss how a special commutative ring, _dual numbers_,
which are defined similar to complex numbers,
facilitate fast and accurate computation of derivatives.

*II: Computing with matrices*

1. [Structured Matrices](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/II.1.StructuredMatrices.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/II.1.StructuredMatrices.pdf)): we discuss types of structured matrices (dense, triangular, and banded).
2. [Orthogonal Matrices](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/II.2.OrthogonalMatrices.ipynb)
([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/II.2.OrthogonalMatrices.pdf)): we discuss types of orthogonal
and unitary matrices (permutations, rotations, and reflections).
3. [Least Squares and QR](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/II.3.QR.ipynb)
([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/II.3.QR.pdf)): we discuss least squares and the computation of the QR factorisation.
4. [PLU and Cholesky](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/II.4.LU.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/II.4.LU.pdf)): we discuss
the PLU and Cholesky factorisations, as well as symmetric positive definite matrices.
5. [Norms](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/II.5.Norms.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/II.5.Norms.pdf)): we discuss vector and matrix norms.
6. [Singular Value Decomposition](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/II.6.SVD.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/II.6.SVD.pdf)): we discuss the Singular Value Decomposition (SVD) and 2-norms of matrices.
7. [Condition Numbers](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/II.7.ConditionNumbers.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/II.7.ConditionNumbers.pdf)): we discuss stability, backward error analysis, and  condition numbers.


*III: Computing with functions*

1. [Fourier Expansions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/III.1.Fourier.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/III.1.Fourier.pdf)): we discuss approximating Fourier expansions using the Trapezium Rule.
2. [Discrete Fourier Transform](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/III.2.DFT.ipynb) ([PDF](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/raw/main/notes/pdf/III.2.DFT.pdf)): we discuss how the approximate Fourier coefficients can be recast as a unitary matrix, and how approximate Fourier expansinos interpolate.
3. [Orthogonal Polynomials](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notes/III.3.OrthogonalPolynomials.ipynb): we introduce orthogonal polynomials and discuss
their properties including three-term recurrences and Jacobi matrices.


**Non-examinable material**: I.3 Example 1/2, II.2 Definition 7/Lemma 2, II.3.2, II.3 Example 2, II.4.1, II.4.2

## Assessment

1. [Practice computer-based exam](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/exams/practice.ipynb)
2. [2021–22 Computer-based exam](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/exams/computerexam2122.ipynb)
3. Computer-based exam: 12:00 17 March 2023 (1 hour in-person exam with 15 minutes to read/download before and 15 minutes to upload after. You may use your own machine.)
3. [Practice final exam](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/exams/practicefinal.pdf)
3. Final exam (pen-and-paper): TBA

## Problem sheets (pen-and-paper)

1. [Integers and Reals](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet1.ipynb) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet1s.ipynb))
2. [Bounding Errors](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet2.ipynb) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet2s.ipynb))
3. [Divided Differences and Dual Numbers](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet3.ipynb)  ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/sheet3s.ipynb))
4. [Structured and Orthogonal Matrices](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet4.ipynb)  ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet4s.ipynb))
5. [QR Factorisations](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet5.ipynb)
([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet5s.ipynb))
6. [Cholesky and Norms](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet6.ipynb)
([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet6s.ipynb))
7. [SVD and Condition Numbers](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet7.ipynb)
([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet7s.ipynb))
8. [Fourier Expansions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/sheet8.ipynb)




## Labs (Julia-based)

1. [Introduction to Julia](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab1.ipynb) ([Raw](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/src/labs/lab1.jl)) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab1s.ipynb))
2. [Interval Arithmetic](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab2.ipynb) ([Raw](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/src/labs/lab2.jl)) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab2s.ipynb))
2. [Divided Differences and Dual Numbers](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab3.ipynb) ([Raw](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/src/labs/lab3.jl)) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab3s.ipynb))
4. [Structured Matrices](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab4.ipynb) ([Raw](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/src/labs/lab4.jl)) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab4s.ipynb))
5. [Orthogonal Matrices](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab5.ipynb) ([Raw](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/src/labs/lab5.jl)) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab5s.ipynb))
6. [Least squares, QR, and Cholesky](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab6.ipynb) ([Raw](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/src/labs/lab6.jl))
([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab6s.ipynb))
7. [Singular value decomposition](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab7.ipynb) ([Raw](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/src/labs/lab7.jl)) 
([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/labs/lab7s.ipynb))


## Lecture material

1. Integers: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture1.ipynb)
2. Floating Point: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture2.ipynb)
3. Arithmetic: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture3.ipynb)
4. Bounding Errors: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture4.ipynb)
5. Divided Differences: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture5.ipynb)
6. Dual Numbers: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture6.ipynb)
7. Structured Matrices: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture7.ipynb)
8. Orthogonal Matrices: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture8.ipynb)
9. Reflections: [Notebook](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/lectures/Lecture9.ipynb)



## Reading List

1. Tobin A. Driscoll & Richard J. Braun, [Fundamentals of Numerical Computation, Julia Edition](https://tobydriscoll.net/fnc-julia/linsys/overview.html), Chapters 1–3, 7
2. Nicholas J. Higham, [Accuracy and Stability of Numerical Algorithms](https://epubs.siam.org/doi/book/10.1137/1.9780898718027?mobileUi=0), Chapters 1–3
1. Michael L. Overton, [Numerical Computing with IEEE Floating Point Arithmetic](https://epubs.siam.org/doi/book/10.1137/1.9780898718072), Chapters 2–6
2. Lloyd N. Trefethen & David Bau III, [Numerical Linear Algebra](https://my.siam.org/Store/Product/viewproduct/?ProductId=950/&ct=c257a1956367c57b599612fbf383d0d3c674af4f9181d827444b5cdaca95b0686d6d20467a7c1e3290fb5b31c310ce74f5b2ede375934b844b1171bc734358e2), Chapters 1–4
3. Lloyd N. Trefethen, [Approximation Theory and Approximation Practice](https://people.maths.ox.ac.uk/trefethen/ATAP/ATAPfirst6chapters.pdf), Chapters 1–4, 17–19
4. [The Julia Documentation](https://docs.julialang.org)
5. [The Julia–Matlab–Python Cheatsheet](https://cheatsheets.quantecon.org)
6. Ben Lauwens, [Think Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book)
7. David A. Ham, [Just enough Git to get by](https://object-oriented-python.github.io/a2_git.html)

## What is numerical analysis?

Broadly speaking, numerical analysis is the study of approximating
solutions to _continuous problems_ in mathematics, for example, integration, differentiation,
and solving differential equations. There are three key topics in numerical analysis:

1. Design of algorithms: discuss the construction of algorithms and their implmentation in
software.
2. Convergence of algorithms: proving under which conditions algorithms converge to the
true solution, and the rate of convergence.
3. Stability of algorithms: the study of robustness of algorithms to small perturbations in
data, for example, those that arise from measurement error, errors if data are themselves computed using
algorithms, or simply errors arising from the way computers represent real numbers.

The modern world is built on numerical algorithms:


1. [Fast Fourier Transform (FFT)](https://en.wikipedia.org/wiki/Fast_Fourier_transform): Gives a highly efficient way of computing Fourier  coefficients from function samples,
and is used in many places, e.g., the mp3 format for compressing audio and JPEG image format.
(Though, in a bizarre twist, GIF, a completely uncompressed format, has made a remarkable comeback.)
2. [Singular Value Decomposition (SVD)](https://en.wikipedia.org/wiki/Singular_value_decomposition): Allows for approximating matrices by those with low rank. This is related to the [PageRank algorithm](https://en.wikipedia.org/wiki/PageRank) underlying Google.
3. [Stochastic Gradient Descent (SGD)](https://en.wikipedia.org/wiki/Stochastic_gradient_descent): Minima of high-dimensional functions can be effectively computed using gradients
in a randomised algorithm. This is used in the training of machine learning algorithms.
4. [Finite element method (FEM)](https://en.wikipedia.org/wiki/Finite_element_method):
used to solve many partial differential equations including  in aerodynamics and
weather prediction. [Firedrake](https://firedrakeproject.org) is a major project based at
Imperial that utilises finite element method.


This is not to say that numerical analysis is only important in applied mathematics.
It is playing an increasing important role in pure mathematics with important proofs based on numerical computations:

1. [The Kepler conjecture](https://en.wikipedia.org/wiki/Kepler_conjecture). This 400 year conjecture on optimal sphere packing
was finally proved in 2005 by Thomas Hales using numerical linear programming.
2. [Numerical verification of the Riemann Hypothesis](https://en.wikipedia.org/wiki/Riemann_hypothesis#Numerical_calculations).
It has been proved that there are no zeros of the Riemann zeta function off the critical line provided the imaginary part is
less than 30,610,046,000.
3. [Steve Smale's 14th problem](https://en.wikipedia.org/wiki/Lorenz_system) on the stability of the Lorenz system was solved
using interval arithmetic.

Note these proofs are _rigorous_: as we shall see it is possible to obtain precise error bounds in numerical
calculations, and the computations themselves can be computer-verified
(a la [The Lean Theorem Prover](https://leanprover.github.io)).
As computer-verified proofs become increasingly important, the role of numerical analysis in
pure mathematics will also increase, as it provides the theory for rigorously controlling errors in
computations. Note that there are many computer-assisted proofs that do not fall under numerical analysis because
they do not involve errors in computations or approximation or involve discrete problems, for
example, the proof the [Four Colour Theorem](https://en.wikipedia.org/wiki/Four_color_theorem).

## The Julia Programming Language

In this course we will use the programming language [Julia](https://julialang.org). This is a modern, compiled, high-level,
open-source language developed at MIT. It is becoming increasingly important in high-performance computing and
AI, including by Astrazeneca, Moderna and Pfizer in drug development and clinical trial accelleration, IBM for medical diagnosis, MIT for robot
locomotion, and elsewhere.

It is ideal for a course on numerical analysis because it both allows
_fast_ implementation of algorithms but also has support for _fast_ automatic-differentiation, a feature
that is of increasing importance in machine learning. It also is low level enough that we can
really understand what the computer is doing. As a bonus, it is easy-to-read and fun to write.

To run Julia in a Jupyter notebook on your own machine:

1. Download [Julia v1.8.4](https://julialang.org/downloads/)
2. Open the Julia app which will launch a new window
3. Install the needed packages by typing (`]` will change the prompt to a package manager):
```julia
] add IJulia Plots ColorBitstring SetRounding
```
3. Build Jupyter via
```julia
] bulid IJulia
```
4. Launch Jupyter by typing
```julia
using IJulia
notebook()
```
