//
//  AuthCredentials.swift
//  Freshi
//
//  Created by Casey Roby on 5/25/21.
//

import SwiftUI

// Equitable protocol lets you use "=="
// Codable protocol has something to do with JSON
struct AuthCredsModel: Codable, Equatable {
    var userId: Int
    var token: String
}
