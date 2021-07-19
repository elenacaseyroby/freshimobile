//
//  UserModel.swift
//  Freshi
//
//  Created by Casey Roby on 5/19/21.
//

import SwiftUI

// Identifiable protocol lets you iterate through and simply requires a unique id.
// Equitable protocol lets you use "=="
// Codable protocol has something to do with JSON
struct UserModel: Identifiable, Codable, Equatable {
    var id: Int
    var username: String
    var email: String
    var first_name: String?
    var last_name: String?
//    #if DEBUG
//    static let example = MenuItem(id: UUID(), name: "Maple French Toast", photoCredit: "Joseph Gonzalez", price: 6, restrictions: ["G", "V"], description: "Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…")
//    #endif
}
