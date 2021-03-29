import Foundation

class Priest: Character {

    // le compteur de soins effectués :
    var healDone = 0
    init(name: String) {
        let weapon = Scepter(name: "basic scepter 🔱", damage: 15)
        super.init(name: name, characterType: "Priest 🔱", maxLife: 150, lifePoints: 150, weapon: weapon)
    }
    // fonction réécrite qui présente le nouveau sceptre équipé par le Prêtre en cas de coffre aléatoire apparu :
    override func presentNewWeapon() {
        print("\(name) has now a \(weapon.name), that does \(weapon.damage) healing points.")
    }
    // fonction réécrite qui transforme l'attaque en soin, et qui incrémente les compteurs de soins reçus et donnés :
    override func attack(otherCharacter: Character) -> String {
        otherCharacter.lifePoints += self.weapon.damage
        self.healDone += self.weapon.damage
        otherCharacter.healReceived += self.weapon.damage
        return "\(otherCharacter.name) has been healed 🧪! He has now \(otherCharacter.lifePoints) life points."
    }
    // fonction réécrite qui présente les infos utiles du Prêtre pendant les combats :
    override func fightStats() {
        print("\n\(name) (\(characterType)) ---> "
                + "\nCurrent life points : \(lifePoints) (started with \(maxLife) life points)"
                + "\nHealing points : \(weapon.damage)"
                + "\nHealing done : \(damageDone) points"
                + "\nDamage received : \(damageReceived) points"
                + "\nHeal received : \(healReceived) points")
    }
    // fonction réécrite qui affiche les actions réalisables par le Prêtre :
    override func characterMenu() {
            print("\n What do you want to do with your \(characterType) ?"
            + "\n1. Heal 🧪"
            + "\n2. See stats 📜")
    }
   

}
