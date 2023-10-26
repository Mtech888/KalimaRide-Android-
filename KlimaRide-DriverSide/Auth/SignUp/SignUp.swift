//
//  SignUp.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/08/2023.
//

import SwiftUI
import Combine
import CountryPicker

struct SignUp: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var country: Country? = nil
    @State private var showCountryPicker = false
    @StateObject var signUpApi = SingUpAPiMethod()
    @State var showAlert: Bool = false
    @State var checkBox = false
    @State var enterPass: Bool = false
    @State var confirmPass: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sign Up")
                            .font(.custom(Font.medium, size: 28))
                            .padding(.top, 30)
                        Text("Create a new Account")
                            .font(.custom(Font.light, size: 17))
                    }
                    
                    VStack(spacing: 20) {
                        HStack {
                            CustomTextFeild(fieldBinding: $signUpApi.firstNameBindin,
                                            title: "FIRST NAME",
                                            placeholder: "Type Here")
                            
                            CustomTextFeild(fieldBinding: $signUpApi.lastNameBinding,
                                            title: "LAST NAME",
                                            placeholder: "Type Here")
                        }
                        
                        CustomTextFeild(fieldBinding: $signUpApi.emailBinding,
                                        title: "EMAIL ADDRESS",
                                        placeholder: "Type Here")
                        
                        if enterPass {
                            CustomTextFeild(fieldBinding: $signUpApi.passwordBinding,
                                            title: "ENTER PASSWORD",
                                            placeholder: "Type Here",
                                            icon: "eye-icon",
                                            action: {enterPass.toggle()})
                        } else {
                            CustomSecureField(fieldBinding: $signUpApi.passwordBinding,
                                              title: "ENTER PASSWORD",
                                              icon: "eye-icon",
                                              placeholder: "Type Here",
                                              action: {enterPass.toggle()})
                        }
                        
                        if confirmPass {
                            CustomTextFeild(fieldBinding: $signUpApi.confirmPasswordBinding,
                                            title: "CONFIRM PASSWORD",
                                            placeholder: "Type Here",
                                            icon: "eye-icon",
                                            action: {confirmPass.toggle()})
                        } else {
                            CustomSecureField(fieldBinding: $signUpApi.confirmPasswordBinding,
                                              title: "CONFIRM PASSWORD",
                                              icon: "eye-icon",
                                              placeholder: "Type Here",
                                              action: {confirmPass.toggle()})
                        }
                        
                        VStack(alignment: .leading) {
                            Text("PHONE NUMBER")
                                .font(.custom(Font.regular, size: 13))
                                .foregroundColor(.primary)
                            HStack(spacing: 16) {
                                Button {
                                    showCountryPicker = true
                                } label: {
                                    Text("+" + (signUpApi.countryCode ?? ""))
                                }.sheet(isPresented: $showCountryPicker) {
                                    CountryPicker(country: $country)
                                        .onCountrySelected { country in
                                            signUpApi.countryCode = country.phoneCode
                                        }
                                }
                                
                                TextField("Type Here", text: $signUpApi.numberFieldBinding)
                                    .font(.custom(Font.regular, size: 15))
                                    .keyboardType(.numberPad)
                                    .textContentType(.telephoneNumber)
                            }
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.secondary)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.primary, lineWidth: 0.1)
                            )
                        }
                    }
                    
                    HStack {
                        Button {
                            checkBox.toggle()
                        } label: {
                            Image(checkBox ? "checked" :"checkBox")
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
                }
                .padding()
                
                if checkBox {
                    CustomButton(action: {signUpApi.signUpUser()},
                                 title: "Sign In",
                                 background: Color.theme.appColor,
                                 foreground: .white)
                    .disabled(signUpApi.loginSuccess)
                    .alert(isPresented: $signUpApi.showAlert) {
                        Alert(title: Text(signUpApi.alertTitle),
                              message: Text(signUpApi.alertMessage),
                              dismissButton: .default(Text("OK"))
                        )
                    }
                } else {
                    CustomButton(action: {signUpApi.signUpUser()},
                                 title: "Sign In",
                                 background: Color.theme.appColor,
                                 foreground: .white)
                    .opacity(0.6)
                    .disabled(true)
                }
                
                NavigationLink(
                    destination: TabBar(),
                    isActive: $signUpApi.loginSuccess,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Already Hava An Account?")
                            .foregroundColor(.black)
                        Text("Sign In")
                            .foregroundColor(Color.theme.appColor)
                    }
                }
                .padding(.vertical)
                .font(.custom(Font.medium, size: 15))
            }
        }
        .background(Color.theme.bgColor)
        .navigationBarHidden(true)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
