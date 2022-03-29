import Foundation


class Warrior: Character {

    init(name: String) {
        // instanciate an axe to give the character its appropriate weapon:
        let weapon = Axe(name: "basic axe 🪓", damage: 40)
        super.init(name: name, characterType: "Warrior 🪓", maxLife: 150, lifePoints: 150, weapon: weapon)
    }
}

