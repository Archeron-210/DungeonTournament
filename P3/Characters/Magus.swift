import Foundation
// la classe Magus qui hérite de Character :
class Magus: Character {
    init(name: String) {
        // on crée une instance de Orb pour lui attribuer une arme :
        let weapon = Orb(name:"basic orb 🔮", damage: 30)
        super.init(name: name, characterType: "Magus 🔮", maxLife: 140, lifePoints: 140, weapon: weapon)
    }
}
