import Foundation

class Priest: Character {

    // MARK: - Property

    // heal counter:
    var healDone = 0

    // MARK: - Init

    init(name: String) {
        // instanciate a scepter to give the character its appropriate weapon:
        let weapon = Scepter(name: "basic scepter 🔱", damage: 15)
        super.init(name: name, characterType: "Priest 🔱", maxLife: 150, lifePoints: 150, weapon: weapon)
    }

    // MARK: - Functions overrides

    override func present() {
        print("\nHe is a \(characterType) with \(lifePoints) life points, his weapon is a \(weapon.name) and does \(weapon.damage) healing points.")
    }

    override func presentNewWeapon() {
        print("\(name) has now a \(weapon.name), that does \(weapon.damage) healing points.")
    }

    override func characterMenu() {
        print("\n What do you want to do with your \(characterType) ?"
                + "\n1. Heal 🧪"
                + "\n2. See stats 📜")
    }

    override func actionOn(otherCharacter: Character) -> String {
        otherCharacter.lifePoints += self.weapon.damage
        self.healDone += self.weapon.damage
        otherCharacter.healReceived += self.weapon.damage
        return "\(otherCharacter.name) has been healed 🧪! He has now \(otherCharacter.lifePoints) life points."
    }

    override func fightStats() {
        print("\n\(name) (\(characterType)) ---> "
                + "\nCurrent life points : \(lifePoints)"
                + "\nHealing points : \(weapon.damage)"
                + "\nHealing done : \(healDone) points"
                + "\nDamage received : \(damageReceived) points"
                + "\nHeal received : \(healReceived) points")
    }
}
