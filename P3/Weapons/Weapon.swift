//
//  Weapon.swift
//  P3
//
//  Created by Archeron on 22/03/2021.
//

import Foundation

// La classe Weapon :
class Weapon {
    enum WeaponType {
        case bow
        case axe
        case orb
        case scepter
    }
    let name: String
    let damage: Int
    let type: WeaponType

    init(name: String, damage: Int, type: WeaponType) {
        self.name = name
        self.damage = damage
        self.type = type
    }
}
