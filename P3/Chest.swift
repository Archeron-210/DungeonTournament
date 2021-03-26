
import Foundation

class Chest {
// fonction qui doit renvoyer une arme correspondante au personnage qui la reçoit : pour chaque cas, on instancie deux armes correspondantes, puis on choisi aléatoirement une des deux armes grâce à .randomElement(), on stocke le résultat dans une contante et on renvoie ce résultat :
    func openChest(character: Character) -> Weapon {
        switch character {
        case is Warrior:
            // le tableau qui contient les armes instanciées :
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
            break // permet de sortir du switch sans donner plus d'instructions puisque chaque cas a déja une instruction correspondante
        }
        return Weapon(name: "wooden stick", damage: 0, type: .scepter)
    }
}
