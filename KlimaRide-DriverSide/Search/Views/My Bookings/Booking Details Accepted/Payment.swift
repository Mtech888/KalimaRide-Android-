//
//  Payment.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 04/09/2023.
//

import SwiftUI

struct Payment: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var cardTitle: String = ""
    @State var cardNumber: String = ""
    @State var cardDate: String = ""
    @State var cardCVV: String = ""
    @State var menuOpened = false
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Payment", icon: "back-icon", hiddenTitle: "Title")
                    .background(
                        Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    )
                
                Spacer()
                
                ScrollView {
                    Image("payment-page-image")
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    VStack(spacing: 30) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Name on card")
                                .foregroundColor(Color(.systemGray))
                            VStack(spacing: 1) {
                                HStack {
                                    TextField("Maria", text: $cardTitle)
                                        .foregroundColor(.black)
                                    Image("user-dark-icon")
                                }
                                Divider()
                                
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Card Number")
                                .foregroundColor(Color(.systemGray))
                            HStack {
                                TextField("**** **** **** ****", text: $cardNumber)
                                Image("credit-card-icon")
                            }
                            Divider()
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Expiry Date")
                                    .foregroundColor(Color(.systemGray))
                                HStack {
                                    TextField("22/6/2025", text: $cardDate)
                                    Image("calendar-dark-icon")
                                }
                                Divider()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("CVV")
                                    .foregroundColor(Color(.systemGray))
                                HStack {
                                    TextField("000", text: $cardCVV)
                                    Image("lock-icon")
                                }
                                Divider()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    CustomButton(action: {
                        withAnimation(.easeInOut) {
                            menuOpened.toggle()
                        }
                    }, title: "Confirm Payment",background: Color.theme.appColor, foreground: .white)
                    .padding(.top, 30)
                }
            }
            .padding()
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            
            Receipt(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }
    }
    
    func toggleMenu() {
        menuOpened.toggle()
    }
}

struct Payment_Previews: PreviewProvider {
    static var previews: some View {
        Payment()
    }
}
