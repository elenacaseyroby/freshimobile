//
//  NavToDeepLinkAction.swift
//  Freshi
//
//  Created by Casey Roby on 6/17/21.
//

import Foundation

private func queryComponents(query: String) -> [String: String] {
    // userId=10&authToken=aksdlkhgjshakfh
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

//func setDeepLinkUrlAction(url: URL?, screenManagerStore: ScreenManagerStore) {
//    screenManagerStore.deepLinkUrl = url
////    print("-------------------------")
////    print(url)
////    //freshi://localhost:8000/resetPassword?userId=10&authToken=aksdlkhgjshakfh
////    //freshi://www.freshi.io/resetPassword?userId=10&authToken=aksdlkhgjshakfh
////
////    print(url.query) //  Optional("userId=10&authToken=aksdlkhgjshakfh")
////    print(url.path) // /resetPassword
////    print(url.pathComponents) // ["/", "resetPassword"]
////    print(url.scheme)
////    // parse destination
////    // parse parameters
//}
