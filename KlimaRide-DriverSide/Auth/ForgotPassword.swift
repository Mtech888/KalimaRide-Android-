//
//  ForgotPassword.swift
//  KlimaRideApp
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI

struct ForgotPassword: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var forgotPasswordApi = ForgotPasswordApiMethod()
//    @EnvironmentObject var forgotPassApi: ForgotPasswordApiMethod
    @State var field: String = ""
    
    var body: some View {
        VStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("back-icon")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack(spacing: 20) {
                Image("forgot-pass-image")
                Text("Forgot Password")
                    .font(.custom(Font.medium, size: 24))
                    .padding(.top)
                Text("Provide your account email for which you want to reset the password")
                    .font(.custom(Font.regular, size: 13))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 50)
            
                CustomTextFeild(fieldBinding: $forgotPasswordApi.email, title: "EMAIL ADDRESS", placeholder: "jhonSmith@gmail.com")
                .padding(.top, 30)
            
            CustomButton(action: {forgotPasswordApi.forgotPassword()},
                         title: "Next",background: Color.theme.appColor,
                         foreground: .white)
            .padding(.top)
            .alert(isPresented: $forgotPasswordApi.showAlert) {
                Alert(title: Text(forgotPasswordApi.alertTitle),
                      message: Text(forgotPasswordApi.alertMessage),
                      dismissButton: .default(Text("OK"))
                )
            }
            
            NavigationLink(destination: Verification(serverOtpCode: $forgotPasswordApi.code),
                           isActive: $forgotPasswordApi.verificationStatus,
                           label: {
                EmptyView()
            })
            .hidden()
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
