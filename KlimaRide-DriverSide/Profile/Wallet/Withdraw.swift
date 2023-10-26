//
//  Withdraw.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 23/08/2023.
//

import SwiftUI

struct Withdraw: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var amountField: String = ""
    @State var bankField: String = ""
    @State var accountNumberField: String = ""
    @State var accountTilteField: String = ""
    @State var branchCodeField: String = ""

    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Withdraw", icon: "back-icon", hiddenTitle: "Title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        CustomTextFeild(fieldBinding: $amountField, title: "Enter Amount", placeholder: "Type Here")
                        
                        HStack {
                            Text("Available amount: ")
                            Text("$400")
                        }
                        .font(.custom(Font.medium, size: 13))
                        .foregroundColor(Color.theme.appColor)
                    }
                    
                    CustomTextFeild(fieldBinding: $bankField, title: "Enter Bank Name", placeholder: "Type Here")
                    
                    CustomTextFeild(fieldBinding: $accountNumberField, title: "Enter Account Number", placeholder: "Type Here")
                    
                    CustomTextFeild(fieldBinding: $accountTilteField, title: "Enter Account Title", placeholder: "Type Here")
                    
                    CustomTextFeild(fieldBinding: $branchCodeField, title: "Enter Branch Code", placeholder: "Type Here")
                    
                }
                .padding()
                
                CustomButton(title: "Withdraw", background: Color.theme.appColor, foreground: .white)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct Withdraw_Previews: PreviewProvider {
    static var previews: some View {
        Withdraw()
    }
}
