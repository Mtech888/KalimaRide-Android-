//
//  OneWayRide.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 06/09/2023.
//

import SwiftUI

struct OneWayRide: View {
    @StateObject var ridePostApi = RidePostApiMethod()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                CustomTextFeild(fieldBinding: $ridePostApi.rideTitle, title: "Ride Title", placeholder: "Type Here")
                
                CustomTextFeild(fieldBinding: $ridePostApi.departureCity, title: "City of Departure", placeholder: "Type Here")
                
                CustomTextFeild(fieldBinding: $ridePostApi.arrivalCity, title: "City of Arrival", placeholder: "Type Here")
                
                VStack(alignment: .leading) {
                    Text("Ride Price")
                        .font(.custom(Font.regular, size: 13))
                        .foregroundColor(.primary)
                    
                    HStack {
                        TextField("type Here", value: $ridePostApi.perSeatPrice, format: .number)
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

                VStack(alignment: .leading) {
                    Text("Seats Available")
                        .font(.custom(Font.regular, size: 13))
                        .foregroundColor(.primary)
                    
                    HStack {
                        TextField("type Here", value: $ridePostApi.numberOfSeats, format: .number)
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
                
                HStack(spacing: 20) {
                    CustomTextFeild(fieldBinding: $ridePostApi.leavingDate, title: "Leaving Date", placeholder: "Select Date", icon: "date-icon")
                    Text("at")
                        .padding(.top)
                        .font(.custom(Font.regular, size: 13))
                    CustomTextFeild(fieldBinding: $ridePostApi.leavingTime, title: "", placeholder: "Select Time", icon: "time-iconGreen")
                        .padding(.top, 10)
                }
                
                    CustomButton(action: {
//                        ridePostApi.showLoader = true
                        ridePostApi.success = true
                        ridePostApi.oneWayRide = true
                    }, title: "Next", background: Color.theme.appColor, foreground: .white)
                        .padding(.top)
                        .padding(.bottom)
                        .alert(isPresented: $ridePostApi.showAlert) {
                            Alert(title: Text(ridePostApi.alertTitle),
                                  message: Text(ridePostApi.alertMessage),
                                  dismissButton: .default(Text("OK"))
                            )
                        }

                        NavigationLink(
                            destination: RideDetail().environmentObject(ridePostApi),
                            isActive: $ridePostApi.success,
                            label: {
                                EmptyView()
                            }
                        )
                        .hidden()
                
//                NavigationLink(destination: RideDetail().environmentObject(ridePostApi)) {
//                    Text("NEXT")
//                        .foregroundColor(.white)
//                        .font(.custom(Font.regular, size: 16))
//                }
//                .frame(width: UIScreen.main.bounds.width * 0.95, height: 50, alignment: .center)
//                .background(Color.theme.appColor)
//                .cornerRadius(10)
            }
            .padding(.top)
            
            if ridePostApi.showLoader {
                ProgressView()
                    .foregroundColor(.gray)
            }
        }
    }
}

struct OneWayRide_Previews: PreviewProvider {
    static var previews: some View {
        OneWayRide()
    }
}
