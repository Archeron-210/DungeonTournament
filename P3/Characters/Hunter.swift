import Foundation

class Hunter: Character {

    init(name: String) {
        // instanciate a bow to give the character its appropriate weapon:
        let weapon = Bow(name: "basic bow 🏹", damage: 20)
        super.init(name: name, characterType: "Hunter 🏹", maxLife: 140, lifePoints: 140, weapon: weapon)
    }
}

