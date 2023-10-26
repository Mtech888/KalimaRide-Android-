//
//  AddStopover.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 06/09/2023.
//

import SwiftUI

struct AddStopover: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var ridePostApi: RidePostApiMethod
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()},
                         title: "",
                         icon: "back-icon")
            
            VStack(alignment: .leading, spacing: 20){
                Text("Add stopover to get more passengers")
                    .font(.custom(Font.medium, size: 26))
                
                ForEach(formattedAddresses, id: \.self) { address in
                        StopoverLocation(image: "pin", title: address)
                    }
                
//                StopoverLocation(image: "pin", title: "8614 Mcclellan Rd New York, United States")
//                
//                StopoverLocation(image: "pin", title: "8614 Mcclellan Rd New York, United States")
                
                NavigationLink {
                    AddCity().environmentObject(ridePostApi)
                } label: {
                        HStack {
                            Image("add-stepper")
                            
                            Text("Add City")
                                .foregroundColor(Color.theme.appColor)
                                .font(.custom(Font.regular, size: 15))
                        }
                }
            }
            .padding()
            
            NavigationLink {
                AddPrice().environmentObject(ridePostApi)
            } label: {
                CustomButton(action: {}, title: "Next", background: Color.theme.appColor, foreground: .white)
            }
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct AddStopover_Previews: PreviewProvider {
    static var previews: some View {
        AddStopover()
    }
}
