//
//  GetTermsAction.swift
//  Freshi
//
//  Created by Casey Roby on 8/13/21.
//

import Foundation


// Update password and log in user.
func getTermsAction(
    termsStore: TermsStore,
    onSuccess: @escaping () -> Void,
    onError: @escaping (RequestError) -> Void,
    onComplete: @escaping () -> Void) {
    FreshiRequest(
        endpoint: "terms/",
        method: "GET",
        onComplete: {(data, requestError) in
            struct Terms: Identifiable, Codable, Equatable {
                var id: Int
                var body: String
                var date_published: String
            }
            struct TermsResponse: Codable, Equatable {
                var terms: Terms
            }
            if let requestError = requestError {
                // If request failed return error.
                onError(requestError)
                print(requestError.statusCode)
                print(requestError.errorMessage ?? "")
            }
            else {
                // If success, log user in by setting auth creds in cache and updating authStore.isLoggedIn state.
                if let data = data {
                    if let termsResponse = try? JSONDecoder().decode(TermsResponse.self, from: data) {
                        // set terms in state
                        let terms = termsResponse.terms
                        DispatchQueue.main.async {
                            termsStore.body = terms.body
                            let dateFormatter: DateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSS"
                            termsStore.datePublished = dateFormatter.date(from: terms.date_published) ?? Date()                        }
                    }
                }
            }
            onComplete()})
}


