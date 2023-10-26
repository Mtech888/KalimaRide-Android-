//
//  AddPrice.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 06/09/2023.
//

import SwiftUI

struct AddPrice: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var ridePostApi: RidePostApiMethod
    @State var menuOpened = false
    @State var price = 0
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()},
                             title: "",
                             icon: "back-icon")
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Add price for each Stopover")
                        .font(.custom(Font.medium, size: 26))
                    
                    VStack {
                        ForEach(formattedAddresses, id: \.self) { address in
//                            StopoverLocation(image: "pin", title: address, minusStepper: "minus-stepper", price: "$3", addStepper: "add-stepper")
                            HStack(spacing: 2) {
                                HStack(spacing: 14) {
                                    Image("pin")
                                    
                                    Text(address)
                                        .font(.custom(Font.regular, size: 15))
                                        .frame(width: UIScreen.main.bounds.width * 0.5, alignment: .leading)
                                }

                                Spacer()
                                
                                HStack(spacing: 10) {
//                                    if let minusStepper = minusStepper {
                                        Button {
                                            price -= 1
                                        } label: {
                                            Image("minus-stepper")
                                        }
//                                    }
                                    
//                                    if let price = price {
                                        Text("$\(price)")
                                            .font(.custom(Font.medium, size: 17))
//                                    }
                                    
//                                    if let addStepper = addStepper {
                                        Button {
                                            price += 1
                                        } label: {
                                            Image("add-stepper")
                                        }
//                                    }
                                }
                            }
                            Divider()
                        }
                        
//                        StopoverLocation(image: "pin", title: "8614 Mcclellan Rd New York, United States", minusStepper: "minus-stepper", price: "$3", addStepper: "add-stepper")
//                        
//                        StopoverLocation(image: "pin", title: "8614 Mcclellan Rd New York, United States", minusStepper: "minus-stepper", price: "$3", addStepper: "add-stepper")
                    }
                    .padding(.top)
                }
                .padding()
                    
                CustomButton(action: {
                    withAnimation(.easeInOut) {
                        menuOpened.toggle()
                    }
                    if ridePostApi.oneWayRide {
                        ridePostApi.ridePostOneWay()
                    }else if ridePostApi.returnRide {
                        ridePostApi.ridePostReturn()
                    }else if ridePostApi.returnRide {
                        ridePostApi.recurringRide
                    }
                }, title: "Publish Ride", background: Color.theme.appColor, foreground: .white)
                .padding(.top)
                
                Spacer()
            }
            .ignoresSafeArea()
            
            Receipt(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, menuOpened: menuOpened, toggleMenu: toggleMenu)
            
        }
        .navigationBarHidden(true)
    }
    
    func toggleMenu() {
        menuOpened.toggle()
    }
}

struct AddPrice_Previews: PreviewProvider {
    static var previews: some View {
        AddPrice()
    }
}
