import Foundation

class Magus: Character {
    init(name: String) {
        // instanciate an orb to give the character its appropriate weapon:
        let weapon = Orb(name:"basic orb 🔮", damage: 30)
        super.init(name: name, characterType: "Magus 🔮", maxLife: 140, lifePoints: 140, weapon: weapon)
    }
}
