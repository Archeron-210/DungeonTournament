//
//  Weapon.swift
//  P3
//
//  Created by Archeron on 22/03/2021.
//

import Foundation

class Weapon {

    // MARK: - Enum

    enum WeaponType {
        case bow
        case axe
        case orb
        case scepter
    }

    // MARK: - Properties

    let name: String
    let damage: Int
    let type: WeaponType

    // MARK: - Init

    init(name: String, damage: Int, type: WeaponType) {
        self.name = name
        self.damage = damage
        self.type = type
    }
}
