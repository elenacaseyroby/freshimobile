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


func FreshiRequest(
    endpoint: String,
    method: String,
    queryString: String? = nil,
    headers: [String: String]? = nil,
    body: [String: String]? = nil,
    onComplete: @escaping (Data?, RequestError?) -> Void) {
    // TODO: Change this url before deploy
    // Staging
//    let baseURL = URL(string: "http://www.freshi-staging.us-east-1.elasticbeanstalk.com/api/v1/")!
    // Local
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
    // iOS will not allow a body to be added to GET requests,
    // so we skip the step of adding the body if the method is GET.
    if method != "GET" {
        guard let encoded = try? JSONEncoder().encode(body) else {
            print("Failed to encode body")
            return
        }
        request.httpBody = encoded
    }
    
    // URLSession automatically runs in the background thread – an independent piece of code that’s running at the same time as the rest of our program. This means the network request can be running without stopping our UI from being interactive.
    URLSession.shared.dataTask(with: request) {(data, response, error) in
        // Return error if request failed altogether.
        var errorMessage: String?
        var statusCode = 500
        if let error = error {
            errorMessage = error.localizedDescription
        }
        // Set response statusCode.
        if let response = response {
            // Force response to be type HTTPURLResponse to access statusCode.
            let httpResponse = response as! HTTPURLResponse
            statusCode = httpResponse.statusCode
        }
        
        // Just return data if no error
        if statusCode >= 200 && statusCode < 300 {
            onComplete(data, nil)
            return
        }
        if statusCode == 500 && errorMessage == nil {
            errorMessage = "Server error. Please try again later or reach out to Freshi support."
        }
        let requestError = RequestError(statusCode: statusCode, errorMessage: errorMessage)
        // Else return data and error (might be more descriptive error message in the data in this case).
        onComplete(data, requestError)
        return
    // Without resume() the request does nothing and you’ll be staring at a blank screen. But with it the request starts immediately, it will automatically run in the background, and won’t be destroyed even after our method ends.
    }.resume()
    
}
