//
//  AppleSignin + API.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 10/10/2023.
//

import SwiftUI
import AuthenticationServices

class AppleSignInApiMethod: ObservableObject {
    @Published var id: String = ""
    @Published var fname: String = ""
    @Published var lname: String = ""
    @Published var email: String = ""
    @Published var isSignedIn = false
    @Published var showLoader = false
    let token = authToken
    @State var userDataModel: UserDataModel?
    
//    init?(credentials: ASAuthorizationAppleIDCredential) {
//        guard
//            let firstName = credentials.fullName?.givenName,
//            let lastName = credentials.fullName?.familyName,
//            let email = credentials.email
//        else { return nil }
//
//        self.id = credentials.user
//        self.fname = firstName
//        self.lname = lastName
//        self.email = email
//
//    }
    
    func appleSignin(_ authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            id = appleIDCredential.user
            fname = appleIDCredential.fullName?.givenName ?? ""
            lname = appleIDCredential.fullName?.familyName ?? ""
            email = appleIDCredential.email ?? ""
            
            print("User id is \(id) \n Full Name is \n Email id is \(String(describing: email))")
            
            let params: [String : Any] = ["apple_id": id,
                                          "firstName": "\(fname) \(lname)",
                                          "email": email]
            let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(self.token ?? "")"]
            let url = APIs.baseURL + APIs.appleLogin
            
            AF.request(url, method: .post, parameters: params, headers: headers).response { response in
                let data = response.data
                let str = String(data: data ?? Data(), encoding: .utf8)
                print("THE APPLE DATA IS: \(str ?? "")")
                
                do {
                    let appleSigninModel = try JSONDecoder().decode(AppleSignInModel.self, from: data ?? Data())
                    self.showLoader = false
                    
                    if appleSigninModel.status == false {
                        print(appleSigninModel.message)
                        self.showLoader = false
                    } else if appleSigninModel.status == true {
                        print(appleSigninModel.message)
                    }
                } catch {
                    print(String(describing: error))
                    self.showLoader = false
                }
            }
        }
        
    }
    
    func handleError(_ error: Error) {
            // Handle the error, e.g., display an error message to the user
            print("Sign In with Apple failed: \(error.localizedDescription)")
        }
}
