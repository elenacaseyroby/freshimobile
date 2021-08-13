//
//  GetPrivacyPolicyAction.swift
//  Freshi
//
//  Created by Casey Roby on 8/13/21.
//

import Foundation


// Update password and log in user.
func getPrivacyPolicyAction(
    privacyPolicyStore: PrivacyPolicyStore,
    onSuccess: @escaping () -> Void,
    onError: @escaping (RequestError) -> Void,
    onComplete: @escaping () -> Void) {
    FreshiRequest(
        endpoint: "privacy-policy/",
        method: "GET",
        onComplete: {(data, requestError) in
            struct PP: Identifiable, Codable, Equatable {
                var id: Int
                var body: String
                var date_published: String
            }
            struct PPResponse: Codable, Equatable {
                var privacy_policy: PP
            }
            if let requestError = requestError {
                // If request failed return error.
                onError(requestError)
                print("FAIL")
                print(requestError.statusCode)
                print(requestError.errorMessage ?? "")
            }
            else {
                // If success, log user in by setting auth creds in cache and updating authStore.isLoggedIn state.
                if let data = data {
                    if let pp = try? JSONDecoder().decode(PPResponse.self, from: data) {
                        // set pp in state
                        DispatchQueue.main.async {
                            privacyPolicyStore.body = pp.privacy_policy.body
                            let dateFormatter: DateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSS"
                            privacyPolicyStore.datePublished = dateFormatter.date(from: pp.privacy_policy.date_published) ?? Date()                        }
                    }
                }
            }
            onComplete()})
}


