//
//  ChangePassword.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 23/08/2023.
//

import SwiftUI

struct ChangePassword: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var currentPassField: String = ""
    @State var newPassField: String = ""
    @State var confirmPassField: String = ""
    @StateObject var changePasswordApi = ChangePasswoedApiMethod()
    @State var currentPass: Bool = false
    @State var newPass: Bool = false
    @State var confirmPass: Bool = false
    @State var mismatchPass: Bool = false

    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()},
                         title: "Change Password",
                         icon: "back-icon",
                         hiddenTitle: "Title")
            .background(
                Color.white.shadow(color: Color.black.opacity(0.1),
                                   radius: 5,
                                   x: 0,
                                   y: 5)
            )
            .padding(.top)
            
            VStack {
                Image("change-password-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
            }
            .padding(.top)
            
            VStack(spacing: 25) {
                
                if currentPass {
                    CustomTextFeild(fieldBinding: $changePasswordApi.currentPassword,
                                    title: "CURRENT PASSWORD",
                                    placeholder: "Type Here",
                                    icon: "eye-icon",
                                    action: {currentPass.toggle()})
                }else {
                    CustomSecureField(fieldBinding: $changePasswordApi.currentPassword,
                                      title: "CURRENT PASSWORD",
                                      icon: "eye-icon",
                                      placeholder: "Type Here",
                                      action: {currentPass.toggle()})
                }
                
                if newPass {
                    CustomTextFeild(fieldBinding: $changePasswordApi.newPassword,
                                    title: "NEW PASSWORD",
                                    placeholder: "Type Here",
                                    icon: "eye-icon",
                                    action: {newPass.toggle()})
                }else {
                    CustomSecureField(fieldBinding: $changePasswordApi.newPassword,
                                      title: "NEW PASSWORD",
                                      icon: "eye-icon",
                                      placeholder: "Type Here",
                                      action: {newPass.toggle()})
                }
                
                if confirmPass {
                    CustomTextFeild(fieldBinding: $changePasswordApi.confirmPassword,
                                    title: "CONFIRM PASSWORD",
                                    placeholder: "Type Here",
                                    icon: "eye-icon",
                                    action: {confirmPass.toggle()})
                    
                }else {
                    CustomSecureField(fieldBinding: $changePasswordApi.confirmPassword,
                                      title: "CONFIRM PASSWORD",
                                      icon: "eye-icon",
                                      placeholder: "Type Here",
                                      action: {confirmPass.toggle()})
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .alert(isPresented: $mismatchPass) {
                Alert(title: Text("ERROR"),
                      message: Text("PASSWORD DOES NOT MATCH"),
                      dismissButton: .default(Text("OK"))
                )
            }
            
            
            CustomButton(action: {
                if changePasswordApi.confirmPassword == changePasswordApi.newPassword {
                    changePasswordApi.changePassword()
                }else {
                    print("PASSWORD DOES NOT MATCH")
                    mismatchPass = true
                }
                
            },
                         title: "Save",
                         background: Color.theme.appColor,
                         foreground: .white)
            .padding(.top)
            .alert(isPresented: $changePasswordApi.showAlert) {
                Alert(title: Text(changePasswordApi.alertTitle),
                      message: Text(changePasswordApi.alertMessage),
                      dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
                )
            }
            Spacer()

        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword(currentPassField: "", newPassField: "", confirmPassField: "")
    }
}
