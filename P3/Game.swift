import Foundation

class Game {

    // MARK: - Properties

    // players and character names arrays:
    private var myPlayers: [Player] = []
    private var charactersName: [String] = []
    // battle round counter:
    private var turnCount = 0

    // MARK: - Public

    // game function:
    func start() {
        startMessage()
        // get user choice:
        if let choice = readLine() {
            switch choice {
            case "1":
                print("\n Let's begin ! 🤼‍♂️")
                // instanciate players with their names and display them:
                getPlayersNames()
                showPlayers()
                print("\n Now, each player will build a three characters team.")
                // team building for each player:
                createAndShowTeams()
                print("\n Ready ? Now let the fights begin ! ⚔️")
                // rounds of fights :
                fightTurns()
                // end of game :
                print("\n🛎 END OF THE FIGHTS, DROP YOUR WEAPONS ! 🛎")
                if myPlayers[0].isADamageDealerAlive == true {
                    finalStats(winner: myPlayers[0], loser: myPlayers[1])
                } else {
                    finalStats(winner: myPlayers[1], loser: myPlayers[0])
                }
                finalMessage()
            case "2":
                print("\n Come back soon ! 👋")
                exit(0)
            default:
                // on affiche un message d'erreur si le joueur a entré une réponse invalide :
                print("Sorry, didn't catch what you meant ! Please try again by typing 1 or 2.")
            }
        }
    }

    // name check to avoid doubles:
    func isNameAlreadyTaken(newName: String) -> Bool {
        for name in charactersName {
            if newName == name {
                print("Sorry, this name's already taken, please choose another one.")
                return true
            }
        }
        return false
    }

    // add a name to the characters names array:
    func registerName(name: String) {
        charactersName.append(name)
    }

    // MARK: - Private

    private func startMessage() {
        print("Welcome in Dungeon Tournament ⚔️ ! It's a two players game where each player will choose a team of 3 characters, and have them fight until there's only one team standing."
        + "\n  "
        + "\nWhat do you want to do ?"
        + "\n1. Start game ⚔️"
        + "\n2. Quit game 🚪")
    }

    private func getPlayersNames() {
        print("\nPlayer one, please enter your name :")
        var isValidChoice = false
        while !isValidChoice {
            if let playerOneName = readLineNotEmpty() {
                let firstPlayer = Player(playerName: playerOneName)
                myPlayers.append(firstPlayer)
                print("\nHi \(playerOneName) !")
                isValidChoice = true
            } else {
                print("Sorry, your name should at least contain 1 character, please enter a valid name")
            }
        }
        // while loop that allows second player to pick another name if its first choice is already taken:
        while myPlayers.count < 2 {
            print("\nPlayer two, please enter your name :")
            if let playerTwoName = readLineNotEmpty(), playerTwoName != myPlayers[0].playerName {
                let secondPlayer = Player(playerName: playerTwoName)
                myPlayers.append(secondPlayer)
                print("\nHi \(playerTwoName) !")
            } else {
                print("Sorry, your name should at least contain 1 character, or is already taken, please choose another one :")
            }
        }
    }

    // check if text entered by user is not empty, returns text:
    private func readLineNotEmpty() -> String? {
        guard let text = readLine(), !text.isEmpty else {
            return nil
        }
        return text
    }

    private func createAndShowTeams() {
        // loop that allows each player to build a 3 characters team:
        for player in myPlayers {
            for _ in 1...3 {
                player.buildTeam()
            }
            print("\n \(player.playerName)'s team is complete !")
            player.showTeam()
        }
    }
    
    // fonction qui permet d'afficher les noms des joueurs contenus dans le tableau myPlayers :
    private func showPlayers() {
        print("\nIn this game the players are :")
        for player in myPlayers {
            print(player.playerName)
        }
    }

    private func fightTurns() {
        var currentPlayer: Player = myPlayers[0]
        // loop that runs while players have alive damage dealers in their teams, and manage players turns to play:
        while myPlayers[0].isADamageDealerAlive && myPlayers[1].isADamageDealerAlive {
            if currentPlayer.playerName == myPlayers[0].playerName {
                fightTurn(currentPlayer: myPlayers[0], nextPlayer: myPlayers[1])
                currentPlayer = myPlayers[1]
                turnCount += 1
            } else {
                fightTurn(currentPlayer: myPlayers[1], nextPlayer: myPlayers[0])
                currentPlayer = myPlayers[0]
                turnCount += 1
            }
        }
    }

    // fight function with current player (attacking) and next player (attacked) that allows players to choose a character in their team to perform actions:
    private func fightTurn(currentPlayer: Player, nextPlayer: Player) {
        currentPlayer.selectCharacter()
        // boolean variable to check if user did a valid choice:
        var isValidChoice = false
        // loop that runs while user did not make a valid choice:
        while !isValidChoice {
            if let choice = readLine() {
                let character: Character?
                switch choice {
                case "1":
                    character = currentPlayer.team[0]
                case "2":
                    character = currentPlayer.team[1]
                case "3":
                    character = currentPlayer.team[2]
                default:
                    errorMessage()
                    character = nil
                }
                // unwrapping character and check if character is alive:
                if let characterPicked = character {
                    if characterPicked.isAlive {
                        characterAction(currentPlayer: currentPlayer, nextPlayer: nextPlayer, character: characterPicked)
                        isValidChoice = true
                    } else {
                        print("Sorry, this character is currently dead, please choose another one.")
                    }
                }
            }
        }
    }

    private func characterAction(currentPlayer: Player, nextPlayer: Player, character: Character) {
        // random bonus chest pop:
        randomChest(character: character)
        var isValidChoice = false
        while !isValidChoice {
            // diplay actions for the character:
            character.characterMenu()
            if let choice = readLine() {
                switch choice {
                case "1":
                    while !isValidChoice {
                        // check character type to display correct actions in fights, isValidChoice takes the value returned by corresponding function:
                        if let priest = character as? Priest {
                            isValidChoice = HealerAction(currentPlayer: currentPlayer, priest: priest)
                        } else {
                            isValidChoice = DamageDealerAction(nextPlayer: nextPlayer, character: character)
                        }
                    }
                case "2":
                    // display characters stats:
                    character.fightStats()
                default:
                    errorMessage()
                }
            }
        }
    }

    private func randomChest(character: Character) {
        // randomization of chest apparition:
        let randomChestPop = Int.random(in: 0..<100)
        if randomChestPop < 70 {
            print(" "
                    + "\n\(character.name) found a chest !")
            // instanciate a chest:
            let foundChest = Chest()
            // character that found said chest equiped its new weapon:
            character.weapon = foundChest.openChest(character: character)
            character.presentNewWeapon()
        }
    }

    private func HealerAction(currentPlayer: Player, priest: Priest) -> Bool {
        // display characters in Priest team to choose wich one to heal:
        currentPlayer.selectAlly()
        if let choice = readLine() {
            let ally: Character
            switch choice {
            // give ally a value with user choice:
            case "1":
                ally = currentPlayer.team[0]
            case "2":
                ally = currentPlayer.team[1]
            case "3":
                ally = currentPlayer.team[2]
            default:
                errorMessage()
                return false
            }
            // check if ally is alive:
            if ally.isAlive {
                print(priest.actionOn(otherCharacter: ally))
                return true
            } else {
                print("Sorry, this ally is dead, try again by choosing another ally.")
                return false
            }
        }
        return false
    }

    private func DamageDealerAction(nextPlayer: Player, character: Character) -> Bool {
        // check that character is not a Priest:
        if character is Priest {
            return false
        }
        // display attacked player characters:
        nextPlayer.selectOpponent()
        if let choice = readLine() {
            let opponent: Character
            switch choice {
            case "1":
                // give opponent a value with user choice:
                opponent = nextPlayer.team[0]
            case "2":
                opponent = nextPlayer.team[1]
            case "3":
                opponent = nextPlayer.team[2]
            default:
                errorMessage()
                return false
            }
            // check if character is alive:
            if opponent.isAlive {
                print(character.actionOn(otherCharacter: opponent))
                return true
            } else {
                print("Sorry, this opponent is dead, try again by choosing another opponent.")
                return false
            }
        }
        return false
    }

    private func errorMessage() {
        print("Sorry, didn't catch what you meant ! Please try again by typing 1, 2 or 3.")
    }
    
    private func finalStats(winner: Player, loser: Player) {
        print("\nCongratulations \(winner.playerName), you have won this tournament 🏆 ! Let's take a look at how it went :"
                + "\nNumber of turns : \(turnCount)")
        print("\nFor \(winner.playerName)'s team :")
        for character in winner.team {
            character.fightStats()
        }
        winner.totalTeamStats()
        print("\nAs for you, \(loser.playerName) :")
        for character in loser.team {
            character.fightStats()
        }
        loser.totalTeamStats()
    }
   
    private func finalMessage() {
        print("\nCongratulations to the both of you, it was a pretty fair game. Thanks for playing, come back soon ! 👋")
        exit(0)
    }
}







