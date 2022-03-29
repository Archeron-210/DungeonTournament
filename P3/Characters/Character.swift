
import Foundation

class Character {

    // MARK: - Properties

    let characterType: String
    let name: String
    var weapon: Weapon
    // counters :
    var damageDone = 0
    var damageReceived = 0
    var healReceived = 0
    // with the didSet, allows to manage life points so they don't exceed their max, nor subceed their min:
    var lifePoints: Int {
        didSet {
            if lifePoints > maxLife {
                lifePoints = maxLife
            } else if lifePoints < 0 {
                lifePoints = 0
            }
        }
    }
    // computed property that allows to check if the character is alive:
    var isAlive: Bool {
        return lifePoints > 0
    }
    private let maxLife: Int

    // MARK: - Init

    init(name: String, characterType: String, maxLife: Int, lifePoints: Int, weapon: Weapon){
        self.name = name
        self.characterType = characterType
        self.maxLife = maxLife
        self.lifePoints = lifePoints
        self.weapon = weapon
    }

    // MARK: - Functions

    func present() {
        print("\nHe is a \(characterType) with \(lifePoints) life points, his weapon is a \(weapon.name) and does \(weapon.damage) damage points.")
    }

    func presentNewWeapon() {
        print("\(name) has now a \(weapon.name), that does \(weapon.damage) damage points.")
    }

    func characterMenu() {
        print("\n What do you want to do with your \(characterType) ?"
                + "\n1. Fight ⚔️"
                + "\n2. See stats 📜")
    }

    func actionOn(otherCharacter: Character) -> String {
        otherCharacter.lifePoints -= self.weapon.damage
        self.damageDone += self.weapon.damage
        otherCharacter.damageReceived += self.weapon.damage
        return "\n \(self.weapon.damage) damage points done, well played ! Opponent \(otherCharacter.characterType) has now \(otherCharacter.lifePoints) life points."
    }

    func fightStats() {
        print("\n\(name) (\(characterType)) ---> "
                + "\nCurrent life points : \(lifePoints)"
                + "\nDamage points : \(weapon.damage)"
                + "\nDamage done : \(damageDone) points"
                + "\nDamage received : \(damageReceived) points"
                + "\nHeal received : \(healReceived) points")
    }
}
