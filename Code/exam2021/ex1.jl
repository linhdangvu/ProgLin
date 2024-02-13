###############################
#   Saisir votre code ici.    #
###############################

# Librairies à importer pour utiliser JuMP avec le solver GLPK
using JuMP
using GLPK

# Définition de constantes pour le statut de résolution du problème
const OPTIMAL = JuMP.MathOptInterface.OPTIMAL
const INFEASIBLE = JuMP.MathOptInterface.INFEASIBLE
const UNBOUNDED = JuMP.MathOptInterface.DUAL_INFEASIBLE;

affectationlot = Model(GLPK.Optimizer)

m = 5  # nombre total de machines
l = 10 # nombre total de lots


# déclaration de la variable  d'affecation d'un lot pour une machine
 
@variable(affectationlot, x11 >= 0, Int)
@variable(affectationlot, x12 >= 0, Int)
@variable(affectationlot, x13 >= 0, Int)
@variable(affectationlot, x14 >= 0, Int)    
@variable(affectationlot, x15 >= 0, Int)
@variable(affectationlot, x16 >= 0, Int)
@variable(affectationlot, x17 >= 0, Int)
@variable(affectationlot, x18 >= 0, Int)
@variable(affectationlot, x19 >= 0, Int)
@variable(affectationlot, x110 >= 0, Int)
@variable(affectationlot, x21 >= 0, Int)
@variable(affectationlot, x22 >= 0, Int)
@variable(affectationlot, x23 >= 0, Int)
@variable(affectationlot, x24 >= 0, Int)
@variable(affectationlot, x25 >= 0, Int)
@variable(affectationlot, x26 >= 0, Int)
@variable(affectationlot, x27 >= 0, Int)
@variable(affectationlot, x28 >= 0, Int)
@variable(affectationlot, x29 >= 0, Int)
@variable(affectationlot, x210 >= 0, Int)
@variable(affectationlot, x31 >= 0, Int)
@variable(affectationlot, x32 >= 0, Int)
@variable(affectationlot, x33 >= 0, Int)
@variable(affectationlot, x34 >= 0, Int)
@variable(affectationlot, x35 >= 0, Int)
@variable(affectationlot, x36 >= 0, Int)
@variable(affectationlot, x37 >= 0, Int)
@variable(affectationlot, x38 >= 0, Int)
@variable(affectationlot, x39 >= 0, Int)
@variable(affectationlot, x310 >= 0, Int)
@variable(affectationlot, x41 >= 0, Int)
@variable(affectationlot, x42 >= 0, Int)
@variable(affectationlot, x43 >= 0, Int)
@variable(affectationlot, x44 >= 0, Int)
@variable(affectationlot, x45 >= 0, Int)
@variable(affectationlot, x46 >= 0, Int)
@variable(affectationlot, x47 >= 0, Int)
@variable(affectationlot, x48 >= 0, Int)
@variable(affectationlot, x49 >= 0, Int)
@variable(affectationlot, x410 >= 0, Int)
@variable(affectationlot, x51 >= 0, Int)
@variable(affectationlot, x52 >= 0, Int)
@variable(affectationlot, x53 >= 0, Int)
@variable(affectationlot, x54 >= 0, Int)
@variable(affectationlot, x55 >= 0, Int)
@variable(affectationlot, x56 >= 0, Int)
@variable(affectationlot, x57 >= 0, Int)
@variable(affectationlot, x58 >= 0, Int)
@variable(affectationlot, x59 >= 0, Int)
@variable(affectationlot, x510 >= 0, Int)



# déclaration de la fonction objective pour laquelle on cherche une affectation lot machine rentable c'est à dire pour un coût minimal 

@objective(affectationlot,Min, 17*x11 + 21*x12 + 22*x13 + 24*x15
            + 15*x16 + 20*x17 + 19*x19 + 18*x110 
            + 23*x21 + 16*x22 + 17*x25
            + 16*x26 + 19*x27 + 25*x28 + 18*x29 + 21*x210 
            + 16*x31 + 20*x32
            + 16*x33 + 25*x34 + 24*x35 + 16*x36 + 17*x37 + 19*x38 + 19*x39
            + 18*x310
                
            + 19*x42 + 22*x43 + 22*x44 + 20*x45 + 16*x46
            + 19*x47 + 17*x48 + 21*x49 + 19*x410
                
            + 18*x51 + 19*x52 + 15*x53
            + 15*x54 + 21*x55 + 25*x56 + 16*x58 + 23*x59 + 15*x510
            )       

# déclaration de contrainte de temps de travail

@constraint(affectationlot, 8*x11 + 15*x12 + 14*x13 + 8*x15
            + 16*x16 + 8*x17 + 9*x19 + 17*x110 <= 18 )

@constraint(affectationlot, 15*x21 + 7*x22 + 11*x25 + 11*x26
            + 12*x27 + 10*x28 + 17*x29 + 16*x210 <= 19 )

@constraint(affectationlot, 21*x31 + 20*x32 + 6*x33 + 22*x34
            + 24*x35 + 10*x36 + 24*x37 + 9*x38 + 21*x39 + 14*x310 <= 25 )

@constraint(affectationlot, 11*x42 + 8*x43 + 14*x44
            + 9*x45 + 5*x46 + 6*x47 + 19*x48 + 19*x49 + 7*x410 <= 19 )

@constraint(affectationlot, 8*x51 + 13*x52 + 13*x53 + 13*x54
            + 10*x55 + 20*x56 + 16*x58 + 16*x59 + 17*x510 <= 20 )

#Affichage du modèle
print(affectationlot)

#Résolution du problème d'optimisation linéaire m par le solveur GLPK
optimize!(affectationlot)

status = termination_status(affectationlot)


if status == INFEASIBLE
    println("Le problème n'est pas réalisable")
elseif status == UNBOUNDED
    println("Le problème est non borné")
elseif status == OPTIMAL
    println("Optimum = ", JuMP.objective_value(affectationlot))
    println("Solution optimale :")
    
    for machine in 1:m
        for lot in 1:l
            println("\tX11 = ", JuMP.value(x11))
            println("\tX12 = ", JuMP.value(x12))
            println("\tX13 = ", JuMP.value(x13))
            println("\tX14 = ", JuMP.value(x14))
            println("\tX15 = ", JuMP.value(x15))
            println("\tX16 = ", JuMP.value(x16))
            println("\tX17 = ", JuMP.value(x17))
            println("\tX18 = ", JuMP.value(x18))
            println("\tX19 = ", JuMP.value(x19))
            println("\tX110 = ", JuMP.value(x110))
            println("\tX21 = ", JuMP.value(x21))
            println("\tX22 = ", JuMP.value(x22))
            println("\tX23 = ", JuMP.value(x23))
            println("\tX24 = ", JuMP.value(x24))
            println("\tX25 = ", JuMP.value(x25))
            println("\tX26 = ", JuMP.value(x26))
            println("\tX27 = ", JuMP.value(x27))
            println("\tX28 = ", JuMP.value(x28))
            println("\tX29 = ", JuMP.value(x29))
            println("\tX210 = ", JuMP.value(x210))
            println("\tX31 = ", JuMP.value(x31))
            println("\tX32 = ", JuMP.value(x32))
            println("\tX33 = ", JuMP.value(x33))
            println("\tX34 = ", JuMP.value(x34))
            println("\tX35 = ", JuMP.value(x35))
            println("\tX36 = ", JuMP.value(x36))
            println("\tX37 = ", JuMP.value(x37))
            println("\tX38 = ", JuMP.value(x38))
            println("\tX39 = ", JuMP.value(x39))
            println("\tX310 = ", JuMP.value(x310))
            println("\tX41 = ", JuMP.value(x41))
            println("\tX42 = ", JuMP.value(x42))
            println("\tX43 = ", JuMP.value(x43))
            println("\tX44 = ", JuMP.value(x44))
            println("\tX45 = ", JuMP.value(x45))
            println("\tX46 = ", JuMP.value(x46))
            println("\tX47 = ", JuMP.value(x47))
            println("\tX48 = ", JuMP.value(x48))
            println("\tX49 = ", JuMP.value(x49))
            println("\tX410 = ", JuMP.value(x410))
            println("\tX51 = ", JuMP.value(x51))
            println("\tX52 = ", JuMP.value(x52))
            println("\tX53 = ", JuMP.value(x53))
            println("\tX54 = ", JuMP.value(x54))
            println("\tX55 = ", JuMP.value(x55))
            println("\tX56 = ", JuMP.value(x56))
            println("\tX57 = ", JuMP.value(x57))
            println("\tX58 = ", JuMP.value(x58))
            println("\tX59 = ", JuMP.value(x59))
            println("\tX510 = ", JuMP.value(x510))
        
    
    
    

        


    
        



