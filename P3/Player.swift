
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
                        switch choice {
                            case "1":
                            print(" "
                                + "\nA Hunter ! Good choice. Now, what will he be named ?")
                                // on récupère le nom du personnage, on instancie ce personnage et on le stocke dans l'équipe du joueur :
                                if let newCharacterName = readLine() {
                                let newCharacter = Hunter(name: newCharacterName)
                                    team.append(newCharacter)
                                    // on affiche un message de bienvenue, la présentation du personnage, puis on passe le statut du choix en "valide" :
                                    print("Welcome \(newCharacterName) !")
                                    newCharacter.present()
                                    isValidChoice = true
                                }
                            case "2":
                            print(" "
                                + "\nA Warrior ! Good choice. Now, what will he be named ?")
                                // on récupère le nom du personnage, on instancie ce personnage et on le stocke dans l'équipe du joueur :
                                if let newCharacterName = readLine() {
                                let newCharacter = Warrior(name: newCharacterName)
                                    team.append(newCharacter)
                                    // on affiche un message de bienvenue, la présentation du personnage, puis on passe le statut du choix en "valide" :
                                    print("Welcome \(newCharacterName) !")
                                    newCharacter.present()
                                    isValidChoice = true
                                }
                            case "3":
                            print(" "
                            + "\nA Magus ! Good choice. Now, what will he be named ?")
                                // on récupère le nom du personnage, on instancie ce personnage et on le stocke dans l'équipe du joueur :
                                if let newCharacterName = readLine() {
                                let newCharacter = Magus(name: newCharacterName)
                                    team.append(newCharacter)
                                    // on affiche un message de bienvenue, la présentation du personnage, puis on passe le statut du choix en "valide" :
                                    print("Welcome \(newCharacterName) !")
                                    newCharacter.present()
                                    isValidChoice = true
                                }
                            case "4":
                            print(" "
                                + "\nA Priest ! Good choice. Now, what will he be named ?")
                                // on récupère le nom du personnage, on instancie ce personnage et on le stocke dans l'équipe du joueur :
                                if let newCharacterName = readLine() {
                                    let newCharacter = Priest(name: newCharacterName)
                                    team.append(newCharacter)
                                    // on affiche un message de bienvenue, la présentation du personnage, puis on passe le statut du choix en "valide" :
                                    print("Welcome \(newCharacterName) !")
                                    newCharacter.present()
                                    isValidChoice = true
                                }
                            default:
                                // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                            print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2, 3 or 4.")
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
    // la fonction qui affiche le nom des personnages de l'équipe pour sélectionner l'attaquant dans les phases de combat :
    func selectCharacter() {
       print(" "
        + "\n\(playerName), select a character :"
        + "\n1. \(team[0].name)"
        + "\n2. \(team[1].name)"
        + "\n3. \(team[2].name)")
    }
    // la fonction qui affiche le nom des personnages et leur type de l'équipe adverse pour sélectionner l'attaqué dans les phases de combat :
    func selectOpponent() {
        print(" "
                + "\nWho do you want your character to fight ?"
                + "\n1.\(team[0].name) (\(team[0].characterType))"
                + "\n2.\(team[1].name) (\(team[1].characterType))"
                + "\n3.\(team[2].name) (\(team[2].characterType))")
    }
    // la fonction qui affiche le nom des personnages et leur type de l'équipe pour sélectionner celui qui reçoit le soin du Priest dans les phases de combat :
    func selectAlly() {
       print(" "
                + "\nWho do you want your Priest to heal ?"
                + "\n1.\(team[0].name) (\(team[0].characterType))"
                + "\n2.\(team[1].name) (\(team[1].characterType))"
                + "\n3.\(team[2].name) (\(team[2].characterType))")
    }
}
