import Foundation


// la fonction qui récupère la réponse utilisateur, créé un joueur avec le nom récupéré, puis le stocke dans un tableau myPlayers, et recommence pour un deuxième joueur en vérifiant que les noms sont bien différents :
func playersNames() {
    print(" "
        + "\nPlayer one, please enter your name :")
    if let playerOneName = readLine() {
        let firstPlayer = Player(playerName: playerOneName)
        myPlayers.append(firstPlayer)
    print(" "
        + "\nHi \(playerOneName) !")
    }
    // la boucle qui permet au second joueur de choisir à nouveau un nom si celui choisi en premier lieux est déjà pris :
    while myPlayers.count < 2 {
        print(" "
            + "\nPlayer two, please enter your name :")
        if let playerTwoName = readLine() {
            if playerTwoName != myPlayers[0].playerName {
            let secondPlayer = Player(playerName: playerTwoName)
            myPlayers.append(secondPlayer)
        print(" "
            + "Hi \(playerTwoName) !")
            } else {
                // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                print("Sorry, this name is already taken")
            }
        }
    }
}

// création d'une fonction qui permet d'afficher les noms des joueurs contenus dans le tableau myPlayers :
func showPlayers() {
    print(" "
        + "\nIn this game the players are :")
    for player in myPlayers {
    print(player.playerName)
    }
}

// Apparition aléatoire du coffre bonus qui contient une arme :
func randomChest(character: Character) {
        let randomChestPop = Int.random(in: 0..<100)
        if randomChestPop < 70 {
            print(" "
                + "\n\(character.name) found a chest !")
            // création du coffre et équipement de l'arme qu'il contient par le personnage qui l'a trouvé :
            let foundChest = Chest()
            character.weapon = foundChest.openChest(character: character)
            character.presentNewWeapon()
        }
}

// création de la fonction qui lance le jeu et récupère le choix utilisateur :
func startGame() {
    print("Welcome in Dungeon Tournament ⚔️ ! It's a two players game where each player will choose a team of 3 characters, and have them fight until there's only one team standing."
    + "\n  "
    + "\nWhat do you want to do ?"
    + "\n1. Start game ⚔️"
    + "\n2. Quit game 🚪")
    // on récupère le choix utilisateur :
    if let choice = readLine() {
        switch choice {
        case "1":
            print(" "
                + "\nLet's begin ! 🤼‍♂️")
            // on instancie les joueurs en récupérant leur nom et on les affiche quand c'est fait :
            playersNames()
            showPlayers()
            print(" "
                + "\nNow, each player will build a three character team.")
            // la boucle qui permet, pour chaque joueur, de créer son équipe et de l'afficher une fois complète :
            for player in myPlayers {
                for _ in 1...3 {
                    player.buildTeam()
                }
                print(" "
                    + "\n\(player.playerName)'s team is complete !")
                player.showTeam()
            }
            print("\n "
                + "Ready ? Now let the fights begin ! ⚔️"
                + "\n ")
            // la variable qui contient le joueur courant :
            var currentPlayer: Player = myPlayers[0]
            // la variable du compteur de tours :
            var turnCount = 0
            // boucle des combats qui permet de les lancer tant que les joueurs ont dans leur équipe des personnages toujours en vie autre que des Prêtres, et qui change le tour des joueurs, suivant lequel vient de terminer son action :
            while myPlayers[0].isADamageDealerAlive && myPlayers[1].isADamageDealerAlive {
                if currentPlayer.playerName == myPlayers[0].playerName {
                    playerTurn(currentPlayer: myPlayers[0], nextPlayer: myPlayers[1])
                    currentPlayer = myPlayers[1]
                    turnCount += 1
                } else {
                    playerTurn(currentPlayer: myPlayers[1], nextPlayer: myPlayers[0])
                    currentPlayer = myPlayers[0]
                    turnCount += 1 
                }
            }
            print("Game over ! Now that the fights have come to an end, it's time to announce the winner :")
        case "2":
            print("Come back soon ! 👋")
            exit(0)
        default:
            // on affiche un message d'erreur si le joueur a entré une réponse invalide :
            print("Sorry, didn't catch what you meant ! Please try again by typing 1 or 2.")
        }
    }
}

// fonction des combats qui prends en paramètre le joueur courant et le joueur suivant, afin de déterminer l'attaquant et l'attaqué, et qui permet de choisir un personnage dans l'équipe pour réaliser des actions :
func playerTurn(currentPlayer: Player, nextPlayer: Player) {
    currentPlayer.selectCharacter()
    // la variable de type Bool qui permet de vérifier si l'utilisateur a fait un choix valide :
    var isValidChoice = false
    // la boucle qui permet de boucler sur les actions possibles tant que l'utilisateur n'a pas fait de choix valide :
    while !isValidChoice {
        // on récupère le choix utilisateur :
        if let choice = readLine() {
            switch choice {
                case "1":
                    playerCharacterAction(currentPlayer: currentPlayer, nextPlayer: nextPlayer, character: currentPlayer.team[0])
                    isValidChoice = true
                case "2":
                    playerCharacterAction(currentPlayer: currentPlayer, nextPlayer: nextPlayer, character: currentPlayer.team[1])
                    isValidChoice = true
                case "3":
                    playerCharacterAction(currentPlayer: currentPlayer, nextPlayer: nextPlayer, character: currentPlayer.team[2])
                    isValidChoice = true
                default:
                    // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                    print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
            }
        }
    }
}

// fonction qui prend en paramètre le joueur courant, le joueur suivant, et le personnage du joueur courrant, afin de réaliser les actions de combat :
func playerCharacterAction(currentPlayer: Player, nextPlayer: Player, character: Character) {
    // la fonction qui fait apparaitre aléatoirement le coffre :
    randomChest(character: character)
    // la variable de type Bool qui permet de vérifier si l'utilisateur à fait un choix valide :
    var isValidChoice = false
    // la boucle qui permet de boucler sur les actions possibles tant que l'utilisateur n'a pas fait de choix valide :
    while !isValidChoice {
        // on affiche les actions réalisables par le personnage :
        character.characterMenu()
        // on récupère le choix utilisateur :
        if let choice = readLine() {
            switch choice {
                case "1":
                    // on boucle à nouveau sur les actions possibles tant que l'utilisateur n'a pas fait de choix valide :
                    while !isValidChoice {
                        // on vérifie le type du peronnage pour adapter ses actions dans les combats, et on remplace de résultat stocké dans isValidChoice par le resultat renvoyé par la fonction HealerAction ou DamageDealerAction suivant le cas :
                        if let priest = character as? Priest {
                            isValidChoice = HealerAction(currentPlayer: currentPlayer, priest: priest)
                        } else {
                            isValidChoice = DamageDealerAction(nextPlayer: nextPlayer, character: character)
                        }
                    }
                case "2":
                    // on affiche les infos du personnage :
                    character.fightStats()
                default:
                    // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                    print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
            }
        }
    }
}

// fonction qui prend en paramètre le joueur courant et le personnage de type Prêtre, qui permet de choisir quel personnage de son équipe va recevoir des soins, puis renvoie une valeur de type Bool :
func HealerAction(currentPlayer: Player, priest: Priest) -> Bool {
    // on affiche les personnages de l'équipe du Prêtre :
    currentPlayer.selectAlly()
    // on récupère le choix utilisateur :
    if let choice = readLine() {
        switch choice {
            case "1":
                print(priest.attack(otherCharacter: currentPlayer.team[0]))
                return true
            case "2":
                print(priest.attack(otherCharacter: currentPlayer.team[1]))
                return true
            case "3":
                print(priest.attack(otherCharacter: currentPlayer.team[2]))
                return true
            default:
                // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
    return false
}
// fonction qui prend en paramètre le joueur attaqué et le personnage du joueur attaquant, qui permet de choisir quel personnage du joueur attaqué va subir l'action du personnage attaquant, et renvoie une valeur de type Bool  :
func DamageDealerAction(nextPlayer: Player, character: Character) -> Bool {
    // on vérifie bien que le type du peronnage n'est pas Prêtre :
    if character is Priest {
        return false
    }
    // on affiche les personnages du joueur attaqué :
    nextPlayer.selectOpponent()
    // on récupère le choix utilisateur :
    if let choice = readLine() {
        switch choice {
            case "1":
                print(character.attack(otherCharacter: nextPlayer.team[0]))
                return true
            case "2":
                print(character.attack(otherCharacter: nextPlayer.team[1]))
                return true
            case "3":
                print(character.attack(otherCharacter: nextPlayer.team[2]))
                return true
            default:
                // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
    return false
}
