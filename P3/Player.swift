
import Foundation

// La classe Player, avec une propriété playerName et son initialiseur, ainsi que les fonctions buildteam(), showTeam(), selectCharacter(), selectOpponent() et selectAlly() :
class Player {
    let playerName: String
    // le tableau qui contient les personnages du joueur :
    var team = [Character]()
    // le compteur de personnage en vie :
    var aliveCharacterCount = 0
    // propriété calculée qui permet de contrôler grâce à une boucle sur tous les personnages de l'équipe qu'il y a toujours des personnages vivants pouvant infliger des dégats :
    var isADamageDealerAlive: Bool {
        for character in team {
            if character.characterType != "Priest 🔱" && character.isAlive {
                return true
            }
        }
        return false
    }
    
    init(playerName: String) {
        self.playerName = playerName
    }
    func characterCount() {
        for character in team {
            if character.isAlive {
                aliveCharacterCount += 1
            }
        }
    }
    
    // la fonction qui permet de construire son équipe :
    func buildTeam() {
        // création d'une variable booléenne qui permet de boucler sur le choix utilisateur, pour que le menu des choix s'affiche tant que l'utilisateur n'a pas entré de choix valide :
        var isValidChoice = false
        while !isValidChoice {
            print(" \n\(playerName), choose a character :"
                    + "\n1. Hunter 🏹"
                    + "\n2. Warrior 🪓"
                    + "\n3. Magus 🔮"
                    + "\n4. Priest 🔱")
            // on récupère le choix utilisateur :
            if let choice = readLine() {
                // on créé une constante qui va stocker un personnage, en optionnel :
                let newTeamMember: Character?
                switch choice {
                // pour chaque cas, on attribue le personnage choisi par le joueur à newTeamMember, et on passe le choix en valide pour sortir de la boucle :
                case "1":
                    newTeamMember = Hunter(name: askName())
                    isValidChoice = true
                case "2":
                    newTeamMember = Warrior(name: askName())
                    isValidChoice = true
                case "3":
                    newTeamMember = Magus(name: askName())
                    isValidChoice = true
                case "4":
                    newTeamMember = Priest(name: askName())
                    isValidChoice = true
                default:
                    // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                    print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2, 3 or 4.")
                    newTeamMember = nil
                }
                // si les instructions se sont bien executées, on instancie un nouveau personnage et on l'ajoute à l'équipe du joueur, puis on affiche sa présentation :
                if let newCharacter = newTeamMember {
                    team.append(newCharacter)
                    newCharacter.present()
                }
            }
        }
    }
    
    // la fonction qui permet d'afficher les personnages de l'équipe :
    func showTeam() {
        print("\n Here is the team :")
        for character in team {
            print("\(character.name), \(character.characterType)")
        }
    }
    
    func totalTeamStats() {
        let totalDamageDone = team[0].damageDone + team[1].damageDone + team[2].damageDone
        let totalDamageReceived = team[0].damageReceived + team[1].damageReceived + team[2].damageReceived
        print("\nTotal damage done : \(totalDamageDone) points"
                + "\nTotal damage received : \(totalDamageReceived) points")
    }
    
    // la fonction qui affiche le nom des personnages de l'équipe pour sélectionner le personnage attaquant dans les phases de combat :
    func selectCharacter() {
        // variable qui contient un index, ce qui va permettre d'afficher un numéro devant le choix du joueur pour qu'il puisse faire sa sélection parmis les choix proposés :
        var index = 0
        print("\n \(playerName), select a character :")
        // boucle for qui va permettre pour chaque personnage d'incrémenter son index, de vérifier s'il est bien vivant, si c'est le cas d'afficher simplement son nom, sinon la mention "DEAD" à la suite :
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name)")
            } else {
                print("\(index). \(character.name) (DEAD ☠️)")
            }
        }
    }
    // la fonction qui affiche le nom des personnages et leur type de l'équipe adverse pour sélectionner l'attaqué dans les phases de combat :
    func selectOpponent() {
        var index = 0
        print("\n Who do you want your character to fight ? ⚔️")
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name) (\(character.characterType))")
            } else {
                print("\(index). \(character.name) (\(character.characterType)) (DEAD ☠️)")
            }
        }
    }
    
    // la fonction qui affiche le nom des personnages de l'équipe et leur type pour sélectionner celui qui reçoit les soins du Prêtre dans les phases de combat :
    func selectAlly() {
        var index = 0
        print("\n Who do you want your Priest to heal ? 🧪")
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name) (\(character.characterType))")
            } else {
                print("\(index). \(character.name) (\(character.characterType)) (DEAD ☠️)")
            }
        }
    }
    
    // fonction qui va permettre de récupérer le nom du personnage :
    private func askName() -> String {
        print("\n Good choice. Now, what will he be named ?")
        // on fait une boucle tant que le joueur n'a pas entré de nom valide :
        while true {
            if let newCharacterName = readLine() {
                // on vérifie que le nom est disponible, si c'est le cas on l'ajoute au tableau de noms :
                if !game.isNameAlreadyTaken(newName: newCharacterName) {
                    game.registerName(name: newCharacterName)
                    print("\n Welcome \(newCharacterName) !")
                    // on sort de la boucle grâce au return une fois qu'un nom valide a bien été choisi :
                    return newCharacterName
                }
            }
        }
    }
    
}
