using Weave

nkwds = (out_path="notes/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")
pkwds = (out_path="sheets/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors --clear-output")
skwds = (out_path="sheets/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")
lkwds = (out_path="labs/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")
ekwds = (out_path="exams/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors  --clear-output")
eskwds = (out_path="exams/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")

##
# notes
##

notebook("src/notes/A.Julia.jmd"; nkwds...)
notebook("src/notes/B.Asymptotics.jmd"; nkwds...)
notebook("src/notes/C.Adjoints.jmd"; nkwds...)


# Part I
notebook("src/notes/I.1.Integers.jmd"; nkwds...)
notebook("src/notes/I.2.Reals.jmd"; nkwds...)
notebook("src/notes/I.3.DividedDifferences.jmd"; nkwds...)
notebook("src/notes/I.4.DualNumbers.jmd"; nkwds...)

# Part II
notebook("src/notes/II.1.StructuredMatrices.jmd"; nkwds...)
notebook("src/notes/II.2.OrthogonalMatrices.jmd"; nkwds...)
notebook("src/notes/II.3.QR.jmd"; nkwds...)
notebook("src/notes/II.4.LU.jmd"; nkwds...)
notebook("src/notes/II.5.Norms.jmd"; nkwds...)
notebook("src/notes/II.6.SVD.jmd"; nkwds...)
notebook("src/notes/II.7.ConditionNumbers.jmd"; nkwds...)

# Part III
notebook("src/notes/III.1.Fourier.jmd"; nkwds...)
notebook("src/notes/III.2.DFT.jmd"; nkwds...)
notebook("src/notes/III.3.OrthogonalPolynomials.jmd"; nkwds...)
notebook("src/notes/III.4.ClassicalOPs.jmd"; nkwds...)
notebook("src/notes/III.5.Interpolation.jmd"; nkwds...)
notebook("src/notes/III.6.Quadrature.jmd"; nkwds...)



# weave("src/notes/A.Julia.jmd"; out_path="notes/html/")
# weave("src/notes/B.Asymptotics.jmd"; out_path="notes/html/")
# weave("src/notes/C.Adjoints.jmd"; out_path="notes/html/")


# # Part I
# weave("src/notes/I.1.Integers.jmd"; out_path="notes/html/")
# weave("src/notes/I.2.Reals.jmd"; out_path="notes/html/")
# weave("src/notes/I.3.DividedDifferences.jmd"; out_path="notes/html/")
# weave("src/notes/I.4.DualNumbers.jmd"; out_path="notes/html/")

# # Part II
# weave("src/notes/II.1.StructuredMatrices.jmd"; out_path="notes/html/")
# weave("src/notes/II.2.OrthogonalMatrices.jmd"; out_path="notes/html/")
# weave("src/notes/II.3.QR.jmd"; out_path="notes/html/")
# weave("src/notes/II.4.LU.jmd"; out_path="notes/html/")
# weave("src/notes/II.5.Norms.jmd"; out_path="notes/html/")
# weave("src/notes/II.6.SVD.jmd"; out_path="notes/html/")
# weave("src/notes/II.7.ConditionNumbers.jmd"; out_path="notes/html/")

# /usr/local/bin/jupyter nbconvert  --ExecutePreprocessor.timeout -1 --allow-chromium-download --to webpdf *.ipynb
# pdfunite pdf/*.pdf Notes.pdf
#####
# sheets
#####

write("src/sheets/sheet1.jmd", replace(read("src/sheets/sheet1s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet1.jmd"; pkwds...)
notebook("src/sheets/sheet1s.jmd"; pkwds...)
write("src/sheets/sheet2.jmd", replace(read("src/sheets/sheet2s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet2.jmd"; pkwds...)
notebook("src/sheets/sheet2s.jmd"; pkwds...)
write("src/sheets/sheet3.jmd", replace(read("src/sheets/sheet3s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet3.jmd"; pkwds...)
notebook("src/sheets/sheet3s.jmd"; pkwds...)
write("src/sheets/sheet4.jmd", replace(read("src/sheets/sheet4s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet4.jmd"; pkwds...)
notebook("src/sheets/sheet4s.jmd"; pkwds...)
write("src/sheets/sheet5.jmd", replace(read("src/sheets/sheet5s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet5.jmd"; pkwds...)
notebook("src/sheets/sheet5s.jmd"; pkwds...)
write("src/sheets/sheet6.jmd", replace(read("src/sheets/sheet6s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet6.jmd"; pkwds...)
notebook("src/sheets/sheet6s.jmd"; pkwds...)
write("src/sheets/sheet7.jmd", replace(read("src/sheets/sheet7s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet7.jmd"; pkwds...)
notebook("src/sheets/sheet7s.jmd"; pkwds...)
write("src/sheets/sheet8.jmd", replace(read("src/sheets/sheet8s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet8.jmd"; pkwds...)
notebook("src/sheets/sheet8s.jmd"; pkwds...)
write("src/sheets/sheet9.jmd", replace(read("src/sheets/sheet9s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet9.jmd"; pkwds...)
notebook("src/sheets/sheet9s.jmd"; pkwds...)
write("src/sheets/sheet10.jmd", replace(read("src/sheets/sheet10s.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/sheet10.jmd"; pkwds...)
notebook("src/sheets/sheet10s.jmd"; pkwds...)

write("src/sheets/revision.jmd", replace(read("src/sheets/revisions.jmd", String), r"\*\*SOLUTION\*\*(.*?)\*\*END\*\*"s => ""))
notebook("src/sheets/revision.jmd"; pkwds...)
notebook("src/sheets/revisions.jmd"; pkwds...)

#####
# labs
####

import Literate

Literate.notebook("src/labs/lab1s.jl", "labs/")
Literate.notebook("src/labs/lab1.jl", "labs/")

Literate.notebook("src/labs/lab2s.jl", "labs/")
write("src/labs/lab2.jl", replace(replace(read("src/labs/lab2s.jl", String), r"## SOLUTION(.*?)## END"s => ""), r"@test" => "@test_broken"))
Literate.notebook("src/labs/lab2.jl", "labs/")

Literate.notebook("src/labs/lab3s.jl", "labs/")
write("src/labs/lab3.jl", replace(replace(read("src/labs/lab3s.jl", String), r"## SOLUTION(.*?)## END"s => ""), r"@test" => "@test_broken"))
Literate.notebook("src/labs/lab3.jl", "labs/")

Literate.notebook("src/labs/lab4s.jl", "labs/")
write("src/labs/lab4.jl", replace(replace(read("src/labs/lab4s.jl", String), r"## SOLUTION(.*?)## END"s => ""), r"@test" => "@test_broken"))
Literate.notebook("src/labs/lab4.jl", "labs/")

Literate.notebook("src/labs/lab5s.jl", "labs/")
write("src/labs/lab5.jl", replace(replace(read("src/labs/lab5s.jl", String), r"## SOLUTION(.*?)## END"s => ""), r"@test" => "@test_broken"))
Literate.notebook("src/labs/lab5.jl", "labs/")

Literate.notebook("src/labs/lab6s.jl", "labs/")
write("src/labs/lab6.jl", replace(replace(read("src/labs/lab6s.jl", String), r"## SOLUTION(.*?)## END"s => ""), r"@test" => "@test_broken"))
Literate.notebook("src/labs/lab6.jl", "labs/")

write("src/labs/lab7.jl", replace(replace(read("src/labs/lab7s.jl", String), r"## SOLUTION(.*?)## END"s => ""), r"@test" => "@test_broken"))
Literate.notebook("src/labs/lab7.jl", "labs/")
Literate.notebook("src/labs/lab7s.jl", "labs/")


####
# OLD
####

notebook("src/SpectralTheorem.jmd"; nkwds...)



notebook("src/SingularValues.jmd"; nkwds...)
notebook("src/DifferentialEquations.jmd"; nkwds...)

notebook("src/Fourier.jmd"; nkwds...)
notebook("src/OrthogonalPolynomials.jmd"; nkwds...)
notebook("src/Quadrature.jmd"; nkwds...)

notebook("src/Applications.jmd"; nkwds...)

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