//
//  Verification.swift
//  KlimaRideApp
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI
import AEOTPTextField

struct Verification: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var otpCode: String = ""
    @Binding var serverOtpCode: Int
    var verifiedCode = true
    @EnvironmentObject var forgotPassApi: ForgotPasswordApiMethod
    
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
                Text("Enter Verification Code")
                    .font(.custom(Font.medium, size: 24))
                    .padding(.top)
                Text("Enter the verification code we sent to johnsmith @gmail.com")
                    .font(.custom(Font.regular, size: 13))
                    .multilineTextAlignment(.center)
                
                AEOTPView(
                    text: $otpCode,
                    slotsCount: 4,
                    width: .infinity,
                    height: 50,
                    onCommit: {
                        // do something
                        
                    }
                )
                .padding()
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Time Remaining: 30 Sec")
                    }
                    NavigationLink(destination: NewPassword().environmentObject(forgotPassApi)) {
                        CustomButton(action: {
                            if let userOtp = Int(otpCode),
                               userOtp == serverOtpCode
                            {
                                print("success otp")
                            } else {
                                print("invalid otp")
                            }
                        },
                                     title: "Verify Code",
                                     background: Color.theme.appColor,
                                     foreground: .white)
                    }
                    
                    //                    NavigationLink(destination: NewPassword(),
                    //                                   isActive: verifiedCode,
                    //                                   label: {
                    //                        EmptyView()
                    //                    })
                    //                    .hidden()
                }
                Spacer()
                
            }
            .padding(.top, 40)
        }
        .padding()
        .navigationBarHidden(true)
        
    }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification(serverOtpCode: .constant(1234))
    }
}
