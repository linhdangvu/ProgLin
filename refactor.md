###############################

# Saisir votre code ici.

###############################

# function production(K,T,C)

# m = length(k) # nombre de machines

# l = length(T[1:5]) # nombre de lots

# for machine in 1:m

# for lot in 1:l

# @variables(affectationlot, x[machine,lot], Int)

# end

# end

# @objective(affectationlot, Min, sum(C[machine,lot])\*x[machine,lot] for machine in 1:m for lot in 1:l)

# # contraintes de la capacité des machines

# for machine in 1:m

# @constraint(affectationlot, sum(T[machine, lot]\*x[machine, lot] for lot in 1:l) <= K[machine])

# end

# # contraintes de production du lot

# for lot in 1:l

# @constraint(affectationlot, sum(x[machine, lot] for machine in 1:m) == 1)

# end

# #contrainte de non affectation

# for machine in 1:m

# for lot in 1:l

# if(C[machine, lot] == 0)

# @constraint(affectationlot, x[machine, lot]== 0)

# end

# end

# end

# #Affichage du modèle

# print(affectationlot)

# #Résolution du problème d'optimisation linéaire m par le solveur GLPK

# optimize!(affectationlot)

# status = termination_status(affectationlot)

# if status == INFEASIBLE

# println("Le problème n'est pas réalisable")

# elseif status == UNBOUNDED

# println("Le problème est non borné")

# elseif status == OPTIMAL

# println("le cout minimum de transport est ", JuMP.objective_value(affectationlot))

# println("Solution optimale :")

# for machine in 1:m

# for lot in 1:l

# println("le résultat de l'affectation de la machine $machine au lot $lot est : ", JuMP.objective_value(x[machine,lot]))

# end

# end
