
import Foundation


class Player {

    // MARK: - Properties

    let playerName: String
    var team = [Character]()
    var isADamageDealerAlive: Bool {
        for character in team {
            if character.characterType != "Priest 🔱" && character.isAlive {
                return true
            }
        }
        return false
    }

    // MARK: - Init

    init(playerName: String) {
        self.playerName = playerName
    }
    
    // MARK: - Functions

    func buildTeam() {
        var isValidChoice = false
        while !isValidChoice {
            print(" \n\(playerName), choose a character :"
                    + "\n1. Hunter 🏹"
                    + "\n2. Warrior 🪓"
                    + "\n3. Magus 🔮"
                    + "\n4. Priest 🔱")
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
                    // check if team is not composed of 2 Priest already:
                    if numberOfPriest() >= 2 {
                        print("Sorry, but you can't have a team of more than two Priest. Please choose another character.")
                        newTeamMember = nil
                    } else {
                        newTeamMember = Priest(name: askName())
                        isValidChoice = true
                    }
                default:
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

    func showTeam() {
        print("\n Here is the team :")
        for character in team {
            if character.characterType != "Priest 🔱" {
                print("\(character.name), \(character.characterType) -> life points : \(character.lifePoints), damage points : \(character.weapon.damage)")
            } else {
            print("\(character.name), \(character.characterType) -> life points : \(character.lifePoints), heal points : \(character.weapon.damage)")
            }
        }
    }

    func totalTeamStats() {
        var totalHealDone = 0
        // loop on all team members to check if there is a Priest, if one actually is, then increments the heal counter:
        for character in team {
            if let priest = character as? Priest {
                totalHealDone += priest.healDone
            }
        }
        let totalHealReceived = team[0].healReceived + team[1].healReceived + team[2].healReceived
        let totalDamageDone = team[0].damageDone + team[1].damageDone + team[2].damageDone
        let totalDamageReceived = team[0].damageReceived + team[1].damageReceived + team[2].damageReceived
        print("\nTotal damage done : \(totalDamageDone) points"
                + "\nTotal damage received : \(totalDamageReceived) points"
                + "\nTotal heal done : \(totalHealDone) points"
                + "\nTotal heal received : \(totalHealReceived) points")
    }
    

    func selectCharacter() {
        print("\n \(playerName), select a character :")
        var index = 0
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name) (\(character.characterType), \(character.lifePoints) life points)")
            } else {
                print("\(index). \(character.name) (DEAD ☠️)")
            }
        }
    }

    func selectOpponent() {
        print("\n Who do you want your character to fight ? ⚔️")
        var index = 0
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name) (\(character.characterType), \(character.lifePoints) life points)")
            } else {
                print("\(index). \(character.name) (\(character.characterType)) (DEAD ☠️)")
            }
        }
    }
    

    func selectAlly() {
        print("\n Who do you want your Priest to heal ? 🧪")
        var index = 0
        for character in team {
            index += 1
            if character.isAlive == true {
                print("\(index). \(character.name) (\(character.characterType), \(character.lifePoints) life points)")
            } else {
                print("\(index). \(character.name) (\(character.characterType)) (DEAD ☠️)")
            }
        }
    }

    // MARK: - Private
    
    private func askName() -> String {
        print("\n Good choice. Now, what will he be named ?")
        while true {
            if let newCharacterName = readLine() {
                if !game.isNameAlreadyTaken(newName: newCharacterName) {
                    game.registerName(name: newCharacterName)
                    print("\n Welcome \(newCharacterName) !")
                    return newCharacterName
                }
            }
        }
    }

    private func numberOfPriest() -> Int {
        var priestCount = 0
        for character in team {
            if character.characterType == "Priest 🔱" {
                priestCount += 1
            }
        }
        return priestCount
    }
    
}
