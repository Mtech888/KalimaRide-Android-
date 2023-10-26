//
//  Wallet.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 23/08/2023.
//

import SwiftUI

struct Wallet: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Wallet", icon: "back-icon", hiddenTitle: "Title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .padding(.top)
            ZStack {
                VStack(alignment: .trailing, spacing: 0) {
                    HStack {
                        VStack {
                            Text("Available Balance")
                                .font(.custom(Font.light, size: 12))
                            
                            Text("300 USD")
                                .font(.custom(Font.medium, size: 26))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 40)
                        
                        Spacer()
                        
                        Image("wallet-icon1")
                            .padding(.horizontal)
                    }
                }
                .frame(height: 150)
                .background(Color.theme.walletColor)
                .cornerRadius(20)
                .padding()
                
                NavigationLink(destination: Withdraw(), label: {
                    Text("Withdraw")
                        .font(.custom(Font.medium, size: 13))
                        .foregroundColor(Color.theme.appColor)
                })
                .frame(width: 150, height: 50)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 5, x: 0, y: 5)
                .offset(x: UIScreen.main.bounds.width * 0.25 , y: UIScreen.main.bounds.height * 0.08)
            }
            VStack(alignment: .leading) {
                Text("Withdraw History")
                    .font(.custom(Font.medium, size: 16))
                ScrollView {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("$ 150")
                                    .font(.custom(Font.medium, size: 21))
                                HStack {
                                    Text("24 Nov 2020, 06:23 Pm")
                                        .font(.custom(Font.regular, size: 12))
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Text("Pending")
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 15)
                                            .font(.custom(Font.medium, size: 11))
                                            .foregroundColor(.white)
                                            .background(Color.red)
                                            .cornerRadius(30)
                                    }
                                }
                            }
                            .padding()
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("$ 150")
                                    .font(.custom(Font.medium, size: 21))
                                HStack {
                                    Text("24 Nov 2020, 06:23 Pm")
                                        .font(.custom(Font.regular, size: 12))
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Text("Completed")
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 15)
                                            .font(.custom(Font.medium, size: 11))
                                            .foregroundColor(.white)
                                            .background(Color.theme.appColor)
                                            .cornerRadius(30)
                                    }
                                }
                            }
                            .padding()
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct Wallet_Previews: PreviewProvider {
    static var previews: some View {
        Wallet()
    }
}
