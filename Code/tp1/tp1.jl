# Librairies à importer pour utiliser JuMP avec le solver GLPK
using JuMP
using GLPK

# Définition de constantes pour le statut de résolution du problème
const OPTIMAL = JuMP.MathOptInterface.OPTIMAL
const INFEASIBLE = JuMP.MathOptInterface.INFEASIBLE
const UNBOUNDED = JuMP.MathOptInterface.DUAL_INFEASIBLE;

# Création d'un modèle. Ce modèle fera l'interface avec le solveur GLPK
m = Model(GLPK.Optimizer)

#Création d'une variable x dans le modèle m. x est une variable continue entre 0 et 2.
@variable(m, 0 <= x)

#Création d'une deuxième variable continue y entre 0 et 30
@variable(m, 0 <= y <= 30 )

#Création de la fonction objective du modèle
#=
ATTENTION : 2 écritures possibles : 5x + 3y ou 5 * x + 3 * y.
            Par contre, 5 x + 3 y produit une erreur
=#
@objective(m, Max, 4x + 5y)

#Ajout d'une contrainte dans le modèle
@constraint(m, x + 5y <= 3.5 ) # == # >=


#Affichage du modèle
print(m)

#Résolution du problème d'optimisation linéaire m par le solveur GLPK
optimize!(m)

status = termination_status(m)


if status == INFEASIBLE
    println("Le problème n'est pas réalisable")
elseif status == UNBOUNDED
    println("Le problème est non borné")
elseif status == OPTIMAL
    println("Optimum = ", JuMP.objective_value(m))
    println("Solution optimale :")
    println("\t x = ", JuMP.value(x))
    println("\t y = ", JuMP.value(y))
else
    println("Problème lors de la résolution")
end