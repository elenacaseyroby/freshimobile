//
//  RequestError.swift
//  Freshi
//
//  Created by Casey Roby on 6/11/21.
//

import Foundation

struct RequestError: Codable {
    var statusCode: Int
    var errorMessage: String?
}
