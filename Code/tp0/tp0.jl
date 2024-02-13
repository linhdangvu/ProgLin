# Summary of Julia

# create a basic variable
langage = "Ju" * "lia"

# print something, and it print the same
println(langage, " est)GMb')* un super langage !!!!")
println("Même pas de problème avec les accents...
Ni même avec les caractères unicode ☺ (ʘ‿ʘ)")

#= boucle FOR =#
for i = 1:5
    println("i vaut ", i, " ! ")
end

#= boucle WHILE =#
i = 1
while i <= 5
    println("i vaut ", i , " ! ")
    global(i)
    i+=1
end

#= TABLE =#
#Affichage du tableau prénoms
prénoms = ["Alice", "Bob", "Charlie"]
for p in prénoms
    println(p)
end

nombres = [12, 43, 32, 96, 73, 76]
if length(nombres) > 5
    println("Ce tableau contient plus de 5 nombres")
else
    println("C'est un petit tableau d'au plus 5 nombres")
end

#Parcours du tableau nombres
for nb in nombres
    println("Nombre : ", nb)
end

#Boucle si l'on a besoin des indices du tableau
for i in 1:length(nombres)
    println("Nombre numéro ", i, " = ", nombres[i])
end

#= FUNCTION =#
# Fonction retournant x²-1
function carreMoinsUn(x)
    return x^2 - 1
end
println("carreMoinsUn(3) = ", carreMoinsUn(3))

function modifiePasInt(x)
    x = x+1
end

a = 12
modifiePasInt(a)
println("valeur de a après appel de la fonction modifie = ", a)

function modifieTab(tab)
    push!(tab,12)
end
t = [23, 34, 45]
modifieTab(t)
println("t = ", t)

function valeursRetour(x,y)
    return x+y, x-y, x*y, x/y
end

add, sous, mult, divi = valeursRetour(1,2)
println("1+2 = ", add, "\n1-2 = ", sous, "\n1*2 = $mult \n1/2 = $(divi)")

function maxiTab(tab)
    x=tab[1]
    for e in tab
        if x < e
            x = e
        end
    end
    return x
end
println("maxiTab = ", maxiTab(nombres))