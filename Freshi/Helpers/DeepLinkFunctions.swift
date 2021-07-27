//
//  NavToDeepLinkAction.swift
//  Freshi
//
//  Created by Casey Roby on 6/17/21.
//

import Foundation

// ex deep link formats:
// freshi://localhost:8000/reset-password?userId=10&authToken=aksdlkhgjshakfh
// freshi://www.freshi.io/reset-password?userId=10&authToken=aksdlkhgjshakfh
func queryComponents(query: String) -> [String: String] {
    // Input example"
    // userId=10&authToken=aksdlkhgjshakfh
    // Output example:
    // [
    //      "userId" : "10",
    //      "authToken" : "klasjlfkaghsasd",
    // ]
    var queryComponents: [String: String] = [:]
    let queryKeyValuePairs = query.components(separatedBy: "&")
    for keyValueString in queryKeyValuePairs {
        let keyValueArray = keyValueString.components(separatedBy: "=")
        let key = keyValueArray[0]
        let value = keyValueArray.count > 1 ? keyValueArray[1] : ""
        queryComponents[key] = value
    }
    return queryComponents
}
