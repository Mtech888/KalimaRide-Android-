//
//  GoogleSignIn + API.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 29/08/2023.
//

import SwiftUI
import GoogleSignIn

class GoogleSignInApiMethod: ObservableObject {
    @State var userData: UserDataModel?
    @Published var isSignedIn = false
    var fullName = String()
    var fname = String()
    var lname = String()
    var email = String()
    var number = Int()
    var id = String()
    let token = authToken
    @Published var showLoader = false
    
    func googleSignIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController) { user, error in
            guard error == nil else { return }
            if let error = error {
                print("We found error \(error.localizedDescription)")
            } else {
                if let gmail = user {
                    self.email = gmail.user.profile?.email ?? ""
                    self.id = gmail.user.userID ?? ""
                    self.fullName = gmail.user.profile?.name ?? ""
                    self.fname = gmail.user.profile?.givenName ?? ""
                    self.lname = gmail.user.profile?.familyName ?? ""
                    print("Congrats! \(self.fullName ), Your Googgle ID is \(self.id) and Email is \(self.email)")
                    if self.id != ""{
                        let params : [String : Any] = ["google_id" : self.id, "first_name" : self.fname, "last_name": self.lname , "email" : self.email ]
                        let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(self.token ?? "")"]
                        let url = APIs.baseURL + APIs.googleLogin
                        
                        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
                            let data = response.data
                            let str = String(data: data ?? Data(), encoding: .utf8)
                            print("THE GOOGLE DATA IS: \(str ?? "")")
                            do {
                                let googleSignInModel = try JSONDecoder().decode(GoogleSignInModel.self, from: data ?? Data())
                                self.showLoader = true
                                
                                if googleSignInModel.status == false {
                                    print("\(googleSignInModel.message)")
                                    self.showLoader = false
                                } else if googleSignInModel.status == true {
                                    print("\(googleSignInModel.message)")
                                    print(googleSignInModel.data?.token ?? "")
                                    UserDefaults.standard.set(googleSignInModel.data?.token, forKey: "GOOGLE_AUTH_TOKEN")
                                    authToken = googleSignInModel.data?.token
                                    self.isSignedIn = true
                                    self.email = self.userData?.data?.email ?? ""
                                    self.fname = self.userData?.data?.firstName ?? ""
                                    self.lname = self.userData?.data?.lastName ?? ""
                                    self.showLoader = false
                                }
                            } catch {
                                print(String(describing: error))
                                self.showLoader = false
                            }
                        }
                    }
                }
            }
        }
    }
}

