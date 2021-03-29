import Foundation

// la classe Warrior qui hérite de Character :
class Warrior: Character {
    init(name: String) {
        // on créé une instance de Axe pour lui attribuer son arme :
        let weapon = Axe(name: "basic axe 🪓", damage: 40)
        super.init(name: name, characterType: "Warrior 🪓", maxLife: 150, lifePoints: 150, weapon: weapon)
    }
}

