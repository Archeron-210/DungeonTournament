import Foundation

class Warrior: Character {
    init(name: String) {
        let weapon = Axe(name: "basic axe 🪓", damage: 40)
        super.init(name: name, characterType: "Warrior 🪓", maxLife: 150, lifePoints: 150, weapon: weapon)
    }
    override func present() {
        print(" "
            + "\nHe is a \(characterType) with \(lifePoints) life points, his weapon is a \(weapon.name) and does \(weapon.damage) damage points.")
    }
}

