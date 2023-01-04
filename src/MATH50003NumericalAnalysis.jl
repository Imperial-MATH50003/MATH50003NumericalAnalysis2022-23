using Weave

nkwds = (out_path="notebooks/", doctype = "md2pdf")
pkwds = (out_path="sheets/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors --clear-output")
skwds = (out_path="sheets/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")
ekwds = (out_path="exams/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors  --clear-output")
eskwds = (out_path="exams/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")

##
# notes
##

weave("src/notes/Asymptotics.jmd"; nkwds...)


notebook("src/Julia.jmd"; nkwds...)
notebook("src/Asymptotics.jmd"; nkwds...)
notebook("src/SpectralTheorem.jmd"; nkwds...)

notebook("src/Numbers.jmd"; nkwds...)
notebook("src/Differentiation.jmd"; nkwds...)

notebook("src/StructuredMatrices.jmd"; nkwds...)
notebook("src/Decompositions.jmd"; nkwds...)
notebook("src/SingularValues.jmd"; nkwds...)
notebook("src/DifferentialEquations.jmd"; nkwds...)

notebook("src/Fourier.jmd"; nkwds...)
notebook("src/OrthogonalPolynomials.jmd"; nkwds...)
notebook("src/Quadrature.jmd"; nkwds...)

notebook("src/Applications.jmd"; nkwds...)


##
# problem sheets
##

notebook("src/week1.jmd"; pkwds...)
notebook("src/week2.jmd"; pkwds...)
notebook("src/week4.jmd"; pkwds...)
notebook("src/week5.jmd"; pkwds...)
notebook("src/week9.jmd"; pkwds...)
notebook("src/week10.jmd"; pkwds...)
notebook("src/advanced1.jmd"; pkwds...)
notebook("src/advanced2.jmd"; pkwds...)
notebook("src/advanced3.jmd"; pkwds...)

##
# solutions 
###

notebook("src/week1s.jmd"; skwds...)
notebook("src/week2s.jmd"; skwds...)
notebook("src/week3s.jmd"; skwds...)
notebook("src/week4s.jmd"; skwds...)
notebook("src/week5s.jmd"; skwds...)
notebook("src/week6s.jmd"; skwds...)
notebook("src/week7s.jmd"; skwds...)
notebook("src/week8s.jmd"; skwds...)
notebook("src/week9s.jmd"; skwds...)
notebook("src/week10s.jmd"; skwds...)


##
# exams
##

notebook("src/practice.jmd"; ekwds...)
notebook("src/practices.jmd"; eskwds...)
notebook("src/computerexam.jmd"; ekwds...)
notebook("src/computerexams.jmd"; ekwds...)

##
# extras
##

notebook("src/juliasheet.jmd"; skwds...)