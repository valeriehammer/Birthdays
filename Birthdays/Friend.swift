//
//  Friend.swift
//  Birthdays
//
//  Created by Valerie Hammer on 4/25/25.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
}
