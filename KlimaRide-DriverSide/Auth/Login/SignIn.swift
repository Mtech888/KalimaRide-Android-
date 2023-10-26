//
//  SignIn.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/08/2023.
//

import SwiftUI
import ActivityIndicatorView
import AuthenticationServices

struct SignIn: View {
    @State var emailField: String = ""
    @State var passwordField: String = ""
    @State var loginSuccess = false
    @StateObject var signInApi = SignInApiMethod()
    @StateObject var googleSignInApi = GoogleSignInApiMethod()
    @StateObject var appleSignInApi = AppleSignInApiMethod()
    @State var checkBox = false
    @State var eyeIcon = false
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 0) {
                            Text("Klima")
                                .foregroundColor(.black)
                            Text("Ride")
                                .foregroundColor(Color.theme.appColor)
                        }
                        .font(.custom(Font.bold, size: 38))
                        .padding(.top)
                        
                        Text("Tag Line Here")
                            .font(.custom(Font.regular, size: 18))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sign in")
                            .font(.custom(Font.medium, size: 26))
                        
                        Text("Access to your account")
                            .font(.custom(Font.light, size: 17))
                    }
                    
                    VStack(alignment: .trailing ,spacing: 20) {
                        CustomTextFeild(fieldBinding: $signInApi.emailField,
                                        title: "EMAIL ADDRESS",
                                        placeholder: "Enter Email")
                        
                        if eyeIcon {
                            CustomTextFeild(fieldBinding: $signInApi.passwordField,
                                            title: "PASSWORD",
                                            placeholder: "Enter Password",
                                            icon: "eye-icon",
                                            action: {eyeIcon.toggle()})
                        }else {
                            CustomSecureField(fieldBinding: $signInApi.passwordField,
                                              title: "PASSWORD",
                                              icon: "eye-icon",
                                              placeholder: "Enter Password",
                                              action: {eyeIcon.toggle()})
                        }
                        
                        NavigationLink(destination: ForgotPassword()) {
                            Text("Forgot Password?")
                                .foregroundColor(.black)
                                .font(.custom(Font.medium, size: 14))
                        }
                    }
                }
                .padding()
                
                VStack(spacing: 15 ) {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Button {
                                checkBox.toggle()
                            } label: {
                                Image(checkBox ? "checked" : "checkBox")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 18, height: 18)
                            }
                            
                            Text("I Agree The")
                            Text("Terms")
                                .foregroundColor(Color("app-color"))
                                .underline()
                            Text("And")
                            Text("Conditions")
                                .foregroundColor(Color("app-color"))
                                .underline()
                        }
                        .font(.custom(Font.medium, size: 13))
                        
                        if checkBox {
                            CustomButton(action: {
                                signInApi.showLoader = true
                                signInApi.signInUser()
                            },
                                         title: "Sign In",
                                         background: Color.theme.appColor,
                                         foreground: .white)
                            .alert(isPresented: $signInApi.showAlert) {
                                Alert(title: Text(signInApi.alertTitle),
                                      message: Text(signInApi.alertMessage),
                                      dismissButton: .default(Text("OK"))
                                )
                            }
                        } else {
                            CustomButton(action: {
                                signInApi.showLoader = true
                                signInApi.signInUser()
                            },
                                         title: "Sign In",
                                         background: Color.theme.appColor,
                                         foreground: .white)
                            .opacity(0.6)
                            .disabled(true)
                        }
                        
                        NavigationLink(destination: TabBar(),
                                       isActive: $signInApi.navigateToAnotherView,
                                       label: {
                            EmptyView()
                        })
                        .hidden()
                    }
                    
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(.systemGray4))
                        
                        Text("or")
                            .padding(.horizontal, 5)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(.systemGray4))
                    }
                    .padding(.horizontal)
                    
                    CustomButton(action: {
                        googleSignInApi.showLoader = true
                        googleSignInApi.googleSignIn()
                    } ,
                                 title: "Sign In With Google",
                                 icon: "google-icon",
                                 background: .white,
                                 foreground: .black)
                    .padding(.top)
                    
                    NavigationLink(destination: TabBar(),
                                   isActive: $googleSignInApi.isSignedIn,
                                   label: {
                        EmptyView()
                    })
                    .hidden()
                    
                    SignInWithAppleButton(onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    }, onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            appleSignInApi.appleSignin(authorization)
                        case .failure(let error):
                            appleSignInApi.handleError(error)
                        }
                    })
                    .signInWithAppleButtonStyle(.whiteOutline)
                    .frame(height: 50)
                    .padding()
                    
                    Spacer()
                    VStack{
                        HStack {
                            Text("Don't Have An Account?")
                            
                            NavigationLink(destination: SignUp()) {
                                Text("Sign Up")
                                    .foregroundColor(Color.theme.appColor)
                            }
                        }
                        .font(.custom(Font.medium, size: 15))
                    }
                }
            }
            
            if signInApi.showLoader {
                ActivityIndicatorView(isVisible: $signInApi.showLoader, type: .arcs())
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(Color.theme.appColor)
            }
            
            if googleSignInApi.showLoader {
                ActivityIndicatorView(isVisible: $signInApi.showLoader, type: .arcs())
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(Color.theme.appColor)
            }
        }
        .background(Color.theme.bgColor)
        .navigationBarHidden(true)
    }
    
    //    func configure(_ request: ASAuthorizationAppleIDRequest) {
    //        let appleIDProvider = ASAuthorizationAppleIDProvider()
    //        let request = appleIDProvider.createRequest()
    //        request.requestedScopes = [.fullName, .email]
    //        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    //        authorizationController.performRequests()
    //    }
    
    //    func handle(_ authResult: Result<ASAuthorization, Error>) {
    //        switch authResult {
    //        case .success(let auth):
    //            print(auth)
    //            switch auth.credential {
    //            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
    //                appleSignInApi.appleSignin(credentials: appleIdCredentials)
    //            default:
    //                print(auth.credential)
    //            }
    //        case .failure(let error):
    //            print(error)
    //        }
    //    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
