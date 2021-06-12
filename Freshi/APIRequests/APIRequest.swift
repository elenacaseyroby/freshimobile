//
//  APIRequest.swift
//  Freshi
//
//  Created by Casey Roby on 6/11/21.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI


func APIRequest(
    endpoint: String,
    method: String,
    queryString: String? = nil,
    headers: [String: String]? = nil,
    body: [String: String]? = nil,
    onComplete: @escaping (Data?, Any?, Error?) -> Void) {
    // TODO: Change this url before deploy
    let baseURL = URL(string: "http://localhost:8000/api/v1/")!
    let url = baseURL.appendingPathComponent(endpoint)
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = method
    if let headers = headers {
        for key in headers.keys {
            request.setValue(headers[key], forHTTPHeaderField: key)
        }
    }
    guard let encoded = try? JSONEncoder().encode(body) else {
        print("Failed to encode body")
        return
    }
    request.httpBody = encoded
    
    // URLSession automatically runs in the background thread – an independent piece of code that’s running at the same time as the rest of our program. This means the network request can be running without stopping our UI from being interactive.
    URLSession.shared.dataTask(with: request) {(data, response, error) in
        onComplete(data, response, error)
    // Without resume() the request does nothing and you’ll be staring at a blank screen. But with it the request starts immediately, it will automatically run in the background, and won’t be destroyed even after our method ends.
    }.resume()
    
}
