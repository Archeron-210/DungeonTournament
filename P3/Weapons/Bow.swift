import Foundation

class Bow: Weapon {
    init(name: String, damage: Int) {
        super.init(name: name, damage: damage, type: .bow)
    }
}
