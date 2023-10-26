//
//  NewPassword.swift
//  KlimaRideApp
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI

struct NewPassword: View {
    @State var newPassField: String = ""
    @State var confirmPassField: String = ""
    @StateObject private var resetPasswordApi = ResetPasswordApiMethod()
    @State var newpass: Bool = false
    @State var confirmPass: Bool = false
//    @EnvironmentObject var forgotPassApi: ForgotPasswordApiMethod
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Image("forgot-pass-image")
                Text("Enter New Password")
                    .font(.custom(Font.medium, size: 24))
                    .padding(.top)
                Text("Enter the new password for \(resetPasswordApi.email)")
                    .font(.custom(Font.regular, size: 13))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 50)
            
            VStack(spacing: 30) {
                
                if newpass {
                    CustomTextFeild(fieldBinding: $resetPasswordApi.password,
                                    title: "NEW PASSWORD",
                                    placeholder: "Type Here",
                                    icon: "eye-icon",
                                    action: {newpass.toggle()})
                }else {
                    CustomSecureField(fieldBinding: $resetPasswordApi.password,
                                      title: "NEW PASSWORD",
                                      icon: "eye-icon",
                                      placeholder: "Type Here",
                                      action: {newpass.toggle()})
                }
                
                if confirmPass {
                    CustomTextFeild(fieldBinding: $resetPasswordApi.confirmPassword,
                                    title: "CONFIRM PASSWORD",
                                    placeholder: "Type Here",
                                    icon: "eye-icon",
                                    action: {confirmPass.toggle()})
                }else {
                    CustomSecureField(fieldBinding: $resetPasswordApi.confirmPassword,
                                      title: "CONFIRM PASSWORD",
                                      icon: "eye-icon",
                                      placeholder: "Type Here",
                                      action: {confirmPass.toggle()})
                }
            }
            .padding(.top, 30)
            
            CustomButton(action: {resetPasswordApi.resetPassword()},
                         title: "Save Password",
                         background: Color.theme.appColor,
                         foreground: .white)
            .padding(.top)
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct NewPassword_Previews: PreviewProvider {
    static var previews: some View {
        NewPassword()
    }
}
