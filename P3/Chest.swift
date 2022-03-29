
import Foundation

class Chest {

    // returns a weapon according to the character that finds the chest: for each, instanciate 2 corresponding weapons in an array, then choose randomly wich one to return:
    func openChest(character: Character) -> Weapon {
        switch character {
        case is Warrior:
            let warriorWeapon = [Axe(name: "inferior axe 🪓", damage: 35), Axe(name: "superior axe 🪓", damage: 45)]
            if let warriorWeaponDropped = warriorWeapon.randomElement() {
                return warriorWeaponDropped
            }
        case is Hunter:
            let hunterWeapon = [Bow(name:"inferior bow 🏹", damage: 15), Bow(name: "superior bow 🏹", damage: 25)]
            if let hunterWeaponDropped = hunterWeapon.randomElement() {
                return hunterWeaponDropped
            }
        case is Magus:
            let magusWeapon = [Orb(name: "inferior orb 🔮", damage: 25), Orb(name: "superior orb 🔮", damage: 35)]
            if let magusWeaponDropped = magusWeapon.randomElement() {
                return magusWeaponDropped
            }
        case is Priest:
            let priestWeapon = [Scepter(name: "inferior scepter 🔱", damage: 10), Scepter(name: "superior scepter 🔱", damage: 20)]
            if let priestWeaponDopped = priestWeapon.randomElement() {
                return priestWeaponDopped
            }
        default:
            break
        }
        return Weapon(name: "wooden stick", damage: 0, type: .scepter)
    }
}
