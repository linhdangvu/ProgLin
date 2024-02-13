# Librairies à importer pour utiliser JuMP avec le solver GLPK
using JuMP
using GLPK

# Définition de constantes pour le statut de résolution du problème
const OPTIMAL = JuMP.MathOptInterface.OPTIMAL
const INFEASIBLE = JuMP.MathOptInterface.INFEASIBLE
const UNBOUNDED = JuMP.MathOptInterface.DUAL_INFEASIBLE;

matières = ["BD", "R", "C++", "GL", "IC", "IG", "AC", "PL", "OC", "P", "SDP"]

incompatibilités = [
0 1 0 0 1 0 1 0 0 1 1 ;
1 0 0 0 1 0 1 0 0 1 1 ;
0 0 0 1 1 1 1 0 1 1 1 ;
0 0 1 0 1 1 1 0 0 1 1 ;
1 1 1 1 0 1 1 1 1 1 1 ;
0 0 1 1 1 0 1 0 1 1 1 ;
1 1 1 1 1 1 0 1 1 1 1 ;
0 0 0 0 1 0 1 0 0 1 1 ;
0 0 1 0 1 1 1 0 0 1 1 ;
1 1 1 1 1 1 1 1 1 0 1 ;
1 1 1 1 1 1 1 1 1 1 0 
]

horaires = ["8h-10h", "10h15-12h15", "14h-16h", "16h15-18h15"]


##################
#   Correction   #
##################


function optimise_edt(m, i, h)

    n = length(m)
    M = 1:n
    
    t = length(h)
    H = 1:t
    
    # On a deux jours
    J = 1:2
    
    edt = Model(GLPK.Optimizer)

    #variables y[p] dans 0,1 : est-ce que j'utilise le rouleau p pour p=1,...P
    @variable(edt, z >= 0)

    #varbiale x[m, j, h] = 1 si le contrôle de la matière m a lieu le jour j à l'heure h, 0 sinon
    @variable(edt, x[M, J, H], Bin)

    #La fonction objectif : On cherche à minimiser le nombre de rouleaux decoupes.
    @objective(edt, Min, z)

    
    @constraint(edt, sum(x[m, 1, h] for m ∈ M, h ∈ H) - sum(x[m, 2, h] for m ∈ M, h ∈ H) == z)

    for m ∈ M
        @constraint(edt, sum(x[m,j,h] for j ∈ J, h ∈ H) == 1)
    end
    
    
    for m ∈ M, m2 ∈ M
        if m != m2 && i[m, m2] == 1
            for h ∈ H, j ∈ J
                @constraint(edt, x[m,j,h] + x[m2, j, h] <= 1)
            end
        end
    end
    
    #print(edt)
    JuMP.optimize!(edt)

    for m in M
        for j ∈ J, h ∈ H
            if JuMP.value(x[m,j,h]) != 0
                println(matières[m], " aura lieu le jour $j à l'horaire ", horaires[h])
            end
        end
    end
end

optimise_edt(matières, incompatibilités, horaires)