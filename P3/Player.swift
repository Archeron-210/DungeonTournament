
import Foundation

// définition de la classe Player avec une propriété playerName et son initialiseur, ainsi que les fonctions buildteam(), showTeam(), selectCharacter(), selectOpponent() et selectAlly() :
class Player {
    let playerName: String
    // le tableau qui contient les personnages du joueur :
    var team = [Character]()
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
    
    
    // la fonction qui permet de construire son équipe :
    func buildTeam() {
        // création d'une variable booléenne qui permet de boucler sur le choix utilisateur, pour que le menu des choix s'affiche tant que l'utilisateur n'a pas entré de choix valide :
        var isValidChoice = false
        while !isValidChoice {
            print(" "
                    + "\n\(playerName), choose a character :"
                    + "\n1. Hunter 🏹"
                    + "\n2. Warrior 🪓"
                    + "\n3. Magus 🔮"
                    + "\n4. Priest 🔱")
            // on récupère le choix utilisateur :
            if let choice = readLine() {
                let newTeamMember: Character?
                switch choice {
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
                if let newCharacter = newTeamMember {
                    team.append(newCharacter)
                    newCharacter.present()
                }
            }
        }
    }
    
    func askName() -> String {
        print("\nGood choice. Now, what will he be named ?")
        while true {
            if let newCharacterName = readLine() {
                if !isNameAlreadyTaken(newName: newCharacterName) {
                    charactersName.append(newCharacterName)
                    print("Welcome \(newCharacterName) !")
                    return newCharacterName
                }
            }
        }
    }
    
    
    // la fonction qui permet d'afficher les personnages de l'équipe :
    func showTeam() {
        print("Here is the team :")
        for character in team {
            print("\(character.name), \(character.characterType)")
        }
    }
    // la fonction qui affiche le nom des personnages de l'équipe pour sélectionner le personnage attaquant dans les phases de combat :
    func selectCharacter() {
        // variable qui contient un index, ce qui va permettre d'afficher un numéro devant le choix du joueur pour qu'il puisse faire sa sélection parmis les choix proposés :
        var index = 0
        print("  "
                + "\n\(playerName), select a character :")
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
        print("  "
                + "\nWho do you want your character to fight ?")
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name) (\(character.characterType))")
            } else {
                print("\(index). \(character.name) (\(character.characterType)) (DEAD ☠️)")
            }
        }
    }
    
    // la fonction qui affiche le nom des personnages de l'équipe et leur type  pour sélectionner celui qui reçoit les soins du Prêtre dans les phases de combat :
    func selectAlly() {
        var index = 0
        print(" "
                + "\nWho do you want your Priest to heal ?")
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name) (\(character.characterType))")
            } else {
                print("\(index). \(character.name) (\(character.characterType)) (DEAD ☠️)")
            }
        }
    }
}
