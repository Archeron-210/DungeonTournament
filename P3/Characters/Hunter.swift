import Foundation
// la classe Hunter qui hérite de Character :
class Hunter: Character {
    init(name: String) {
        // on crée une instance de Bow pour lui donner une arme :
        let weapon = Bow(name: "basic bow 🏹", damage: 20)
        super.init(name: name, characterType: "Hunter 🏹", maxLife: 140, lifePoints: 140, weapon: weapon)
    }
}

