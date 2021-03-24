import Foundation

class Hunter: Character {
    init(name: String) {
        let weapon = Bow(name: "basic bow 🏹", damage: 20)
        super.init(name: name, characterType: "Hunter 🏹", maxLife: 140, lifePoints: 140, weapon: weapon)
    }
    override func present() {
        print(" "
            + "\nHe is a \(characterType) with \(lifePoints) life points, his weapon is a \(weapon.name) and does \(weapon.damage) damage points.")
    }
}

