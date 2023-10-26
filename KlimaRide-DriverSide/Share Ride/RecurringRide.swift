//
//  RecurringRide.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 06/09/2023.
//

import SwiftUI

struct RecurringRide: View {
    @State var rideTypeField: String = ""
    @State var rideTitleField: String = ""
    @State var seatsAvailable: String = ""
    @State var priceField: String = ""
    @State var departureField: String = ""
    @State var arrivalField: String = ""
    @State var dateField: String = ""
    @State var timeField: String = ""
    @State var leavingTimeField: String = ""
    @State var returningTimeField: String = ""
    @State var durationfield: String = ""
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
                
                CustomTextFeild(fieldBinding: $ridePostApi.rideDate, title: "Date", placeholder: "Select", icon: "date-icon")
                
                HStack(spacing: 20) {
                    CustomTextFeild(fieldBinding: $ridePostApi.leavingTime, title: "Leaving at", placeholder: "Select Time", icon: "time-iconGreen")
                    Text("at")
                        .padding(.top)
                        .font(.custom(Font.regular, size: 13))
                    CustomTextFeild(fieldBinding: $ridePostApi.returningTime, title: "Returning at (same day)", placeholder: "Select Time", icon: "time-iconGreen")
                }
                
                CustomTextFeild(fieldBinding: $ridePostApi.duration, title: "Duration", placeholder: "Select", icon: "time-iconGreen")
                
                CustomButton(action: {
//                    ridePostApi.showLoader = true
                    ridePostApi.success = true
                    ridePostApi.recurringRide = true
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

struct RecurringRide_Previews: PreviewProvider {
    static var previews: some View {
        RecurringRide()
    }
}
