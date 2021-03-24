import Foundation

class Magus: Character {
    init(name: String) {
        let weapon = Orb(name:"basic orb 🔮", damage: 30)
        super.init(name: name, characterType: "Magus 🔮", maxLife: 140, lifePoints: 140, weapon: weapon)
    }
    override func present() {
        print(" "
            + "\nHe is a \(characterType) with \(lifePoints) life points, his weapon is a \(weapon.name) and does \(weapon.damage) damage points.")
    }
}
