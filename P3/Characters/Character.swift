
import Foundation

// définition de la classe Character avec des propriétés name, characterType, lifePoints, weapon et leur initialiseur :
class Character {
    let characterType: String
    let name: String
    let maxLife: Int
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
    var weapon: Weapon
    // les compteurs de dommages effectués, reçus, et de soins reçus :
    var damageDone = 0
    var damageReceived = 0
    var healReceived = 0
    // propriété calculée qui permet de vérifier si le personnage est en vie grâce au true ou false renvoyé :
    var isAlive: Bool {
        return lifePoints > 0
    }
    
    init(name: String, characterType: String, maxLife: Int, lifePoints: Int, weapon: Weapon){
        self.name = name
        self.characterType = characterType
        self.maxLife = maxLife
        self.lifePoints = lifePoints
        self.weapon = weapon
    }
    func present() {
        print("\(name) -> Life points : \(lifePoints), damage points : \(weapon.damage)")
    }
    // fonction qui permet d'afficher que le personnage est mort :
    func isDead() {
        if isAlive != true {
            print("\(name) is dead.")
        }
    }
    // fonction qui permet d'afficher les infos de la nouvelle arme équipée en cas de coffre aléatoire apparu :
    func presentNewWeapon() {
        print("\(name) has now a \(weapon.name), that does \(weapon.damage) damage points.")
    }
    // fonction qui affiche les infos utiles pendant le combat :
    func fightStats(){
       print(" "
            + "\nLife points : \(lifePoints)"
            + "\nDamage points : \(weapon.damage)"
            + "\nDamage done : \(damageDone)"
            + "\nDamage received : \(damageReceived)"
            + "\nHeal received : \(healReceived)")
    }
// fonction qui retire les points d'attaque de l'attaquant aux points de vie de l'attaqué et incrémente les compteurs de dommages reçus et effectués :
    func attack(otherCharacter: Character) -> String {
        otherCharacter.lifePoints -= self.weapon.damage
        self.damageDone += self.weapon.damage
        otherCharacter.damageReceived += self.weapon.damage
        return "\(self.weapon.damage) damage done, well played ! Opponent \(otherCharacter.characterType) has now \(otherCharacter.lifePoints) life points."
    }
// fonction qui affiche le menu des actions possibles à réaliser avec son personnage :
    func characterMenu() {
        print("  "
        + "\nWhat do you want to do with your \(characterType) ?"
        + "\n1. Fight ⚔️"
        + "\n2. See stats 📜")
    }
  
}
