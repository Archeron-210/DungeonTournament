import Foundation


// création d'une fonction qui récupère la réponse utilisateur, créé un joueur avec le nom récupéré, puis le stocke dans un tableau myPlayers, et recommence pour un deuxième joueur en vérifiant que les noms sont bien différents :
func playersNames() {
    print(" "
        + "\nPlayer one, please enter your name :")
    if let playerOneName = readLine() {
        let firstPlayer = Player(playerName: playerOneName)
        myPlayers.append(firstPlayer)
    print(" "
        + "\nHi \(playerOneName) !")
    }
    while myPlayers.count < 2 {
        print(" "
            + "\nPlayer two, please enter your name :")
        if let playerTwoName = readLine() {
            if playerTwoName != myPlayers[0].playerName {
            let secondPlayer = Player(playerName: playerTwoName)
            myPlayers.append(secondPlayer)
        print("Hi \(playerTwoName) !")
            } else {
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
                + "\nLet the fights begin ! 🤼‍♂️")
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
            // variable qui contient le joueur courant :
            var currentPlayer: Player = myPlayers[0]
            var nextPlayer: Player = myPlayers[1]
            // boucle des combats qui permet de les lancer tant que les joueurs ont dans leur équipe des personnages toujours en vie autre que les Prêtres, et qui change le tour des joueurs, suivant lequel vient de terminer son action :
            while myPlayers[0].isADamageDealerAlive && myPlayers[1].isADamageDealerAlive {
                if currentPlayer.playerName == myPlayers[0].playerName {
                    playerOneTurn()
                    currentPlayer = myPlayers[1]
                    nextPlayer = myPlayers[0]
                    } else {
                    playerTwoTurn()
                    currentPlayer = myPlayers[0]
                    nextPlayer = myPlayers[1]
                        
                    
                }
            }
        case "2":
            print("Come back soon ! 👋")
        default:
            print("Sorry, didn't catch what you meant ! Please try again by typing 1 or 2.")
        }
    }
}

// /!\ fonction brouillon qui permet de choisir l'attaquant (ici pour le premier joueur, qui va donc nécessiter une répétition pour le deuxième joueur si elle reste en l'état) :
func playerOneTurn() {
    myPlayers[0].selectCharacter()
    if let choice = readLine() {
        switch choice {
            case "1":
                playerOneCharacterAction(character: myPlayers[0].team[0])
            case "2":
                playerOneCharacterAction(character: myPlayers[0].team[1])
            case "3":
                playerOneCharacterAction(character: myPlayers[0].team[2])
            default:
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
}


func playerOneCharacterAction(character: Character) {
    randomChest(character: character)
    var isValidChoice = false
    while !isValidChoice {
        character.characterMenu()
        if let choice = readLine() {
            switch choice {
                case "1":
                    while !isValidChoice {
                        if let priest = character as? Priest {
                            isValidChoice = playerOneHealerAction(priest: priest)
                        } else {
                            isValidChoice = playerOneDamageDealerAction(character: character)
                        }
                    }
                case "2":
                    character.fightStats()
                case "3":
                    break
                default:
                    print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
            }
        }
    }
}


func playerOneHealerAction(priest: Priest) -> Bool {
    myPlayers[0].selectAlly()
    if let choice = readLine() {
        switch choice {
            case "1":
                print(priest.attack(otherCharacter: myPlayers[0].team[0]))
                return true
            case "2":
                print(priest.attack(otherCharacter: myPlayers[0].team[1]))
                return true
            case "3":
                print(priest.attack(otherCharacter: myPlayers[0].team[2]))
                return true
            default:
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
    return false
}

func playerOneDamageDealerAction(character: Character) -> Bool {
    if character is Priest {
        return false
    }
    myPlayers[1].selectOpponent()
    if let choice = readLine() {
        switch choice {
            case "1":
                print(character.attack(otherCharacter: myPlayers[1].team[0]))
                return true
            case "2":
                print(character.attack(otherCharacter: myPlayers[1].team[1]))
                return true
            case "3":
                print(character.attack(otherCharacter: myPlayers[1].team[2]))
                return true
            default:
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
    return false
}




func playerTwoTurn() {
    myPlayers[1].selectCharacter()
    if let choice = readLine() {
        switch choice {
            case "1":
                playerOneCharacterAction(character: myPlayers[1].team[0])
            case "2":
                playerOneCharacterAction(character: myPlayers[1].team[1])
            case "3":
                playerOneCharacterAction(character: myPlayers[1].team[2])
            default:
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
}


func playerTwoCharacterAction(character: Character) {
    randomChest(character: character)
    var isValidChoice = false
    while !isValidChoice {
        character.characterMenu()
        if let choice = readLine() {
            switch choice {
                case "1":
                    while !isValidChoice {
                        if let priest = character as? Priest {
                            isValidChoice = playerOneHealerAction(priest: priest)
                        } else {
                            isValidChoice = playerOneDamageDealerAction(character: character)
                        }
                    }
                case "2":
                    character.fightStats()
                case "3":
                    break
                default:
                    print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
            }
        }
    }
}

func playerTwoHealerAction(priest: Priest) -> Bool {
    myPlayers[1].selectAlly()
    if let choice = readLine() {
        switch choice {
            case "1":
                print(priest.attack(otherCharacter: myPlayers[1].team[0]))
                return true
            case "2":
                print(priest.attack(otherCharacter: myPlayers[1].team[1]))
                return true
            case "3":
                print(priest.attack(otherCharacter: myPlayers[1].team[2]))
                return true
            default:
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
    return false
}

func playerTwoDamageDealersAction(character: Character) -> Bool {
    if character is Priest {
        return false
    }
    myPlayers[0].selectOpponent()
    if let choice = readLine() {
        switch choice {
            case "1":
                print(character.attack(otherCharacter: myPlayers[0].team[0]))
                return true
            case "2":
                print(character.attack(otherCharacter: myPlayers[0].team[1]))
                return true
            case "3":
                print(character.attack(otherCharacter: myPlayers[0].team[2]))
                return true
            default:
                print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
        }
    }
    return false
}
