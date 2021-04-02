
import Foundation

// définition de la classe Character avec des propriétés name, characterType, lifePoints, weapon et leur initialiseur :
class Character {
    let characterType: String
    let name: String
    var weapon: Weapon
    // les compteurs de dommages effectués, reçus, et de soins reçus :
    var damageDone = 0
    var damageReceived = 0
    var healReceived = 0
    // on observe la propriété stockée lifePoints : grâce à la méthode didSet, on vérifie que les points de vie ne dépassent jamais les points de vie max, ni ne descendent en dessous de 0 :
    var lifePoints: Int {
        didSet {
            if lifePoints > maxLife {
                lifePoints = maxLife
            } else if lifePoints < 0 {
                lifePoints = 0
            }
        }
    }
    // propriété calculée qui permet de vérifier si le personnage est en vie grâce au true ou false renvoyé :
    var isAlive: Bool {
        return lifePoints > 0
    }
    private let maxLife: Int
    
    init(name: String, characterType: String, maxLife: Int, lifePoints: Int, weapon: Weapon){
        self.name = name
        self.characterType = characterType
        self.maxLife = maxLife
        self.lifePoints = lifePoints
        self.weapon = weapon
    }
    // la fonction qui permet de présenter le personnage :
    func present() {
        print("\nHe is a \(characterType) with \(lifePoints) life points, his weapon is a \(weapon.name) and does \(weapon.damage) damage points.")
    }
    
    // fonction qui permet au personnage de présenter la nouvelle arme équipée en cas de coffre aléatoire apparu :
    func presentNewWeapon() {
        print("\(name) has now a \(weapon.name), that does \(weapon.damage) damage points.")
    }
    // fonction qui affiche les infos utiles pendant le combat :
    func fightStats(){
        print("\n\(name) (\(characterType)) ---> "
                + "\nCurrent life points : \(lifePoints)"
                + "\nDamage points : \(weapon.damage)"
                + "\nDamage done : \(damageDone) points"
                + "\nDamage received : \(damageReceived) points"
                + "\nHeal received : \(healReceived) points")
    }
    // fonction qui retire les points d'attaque de l'attaquant aux points de vie de l'attaqué et incrémente les compteurs de dommages reçus et effectués :
    func actionOn(otherCharacter: Character) -> String {
        otherCharacter.lifePoints -= self.weapon.damage
        self.damageDone += self.weapon.damage
        otherCharacter.damageReceived += self.weapon.damage
        return "\n \(self.weapon.damage) damage points done, well played ! Opponent \(otherCharacter.characterType) has now \(otherCharacter.lifePoints) life points."
    }
    // fonction qui affiche le menu des actions possibles à réaliser avec le personnage :
    func characterMenu() {
        print("\n What do you want to do with your \(characterType) ?"
                + "\n1. Fight ⚔️"
                + "\n2. See stats 📜")
    }
}
