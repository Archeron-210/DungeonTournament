//
//  Weapon.swift
//  P3
//
//  Created by Archeron on 22/03/2021.
//

import Foundation

// création de la classe Weapon
class Weapon {
    enum WeaponType {
        case bow
        case axe
        case orb
        case scepter
    }
    var name: String
    var damage: Int
    var type: WeaponType

    init(name: String, damage: Int, type: WeaponType) {
        self.name = name
        self.damage = damage
        self.type = type
    }
}
