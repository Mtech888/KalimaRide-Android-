//
//  MyVehicles.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 07/09/2023.
//

import SwiftUI

struct MyVehicles: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var apiMethod = MyVehicleApiMethod()
    @StateObject var deleteVehicle = DeleteVehicleApiMethod()
    @State var myVehicle: [VehicleData]?
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()},
                         title: "My Vehicles",
                         icon: "back-icon")
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Which car are you driving?")
                        .font(.custom(Font.medium, size: 26))
                    
                    NavigationLink(destination: AddVehicle()) {
                        HStack {
                            VStack(alignment: .leading ,spacing: 5) {
                                if let myVehicleModel = apiMethod.myVehicleModel {
                                    if myVehicleModel.status {                      ForEach(myVehicleModel.data ?? [], id: \.id) { vehicleData in
                                        HStack {
                                            VStack(alignment: .leading ,spacing: 5) {
                                                Text("\(vehicleData.brandName) \(vehicleData.modelName)")
                                                    .font(.custom(Font.regular, size: 16))
                                                    .foregroundColor(.black)
                                                Text(vehicleData.numberPlate)
                                                    .padding(8)
                                                    .font(.custom(Font.regular, size: 12))
                                                    .foregroundColor(.black)
                                                    .background(Color.theme.bgColor)
                                            }
                                            Spacer()
                                            
                                            Button {
                                                deleteVehicle.deleteVehicle(vehicleId: vehicleData.id) {
                                                    apiMethod.myVehicle()
                                                }
                                            } label: {
                                                Image("delete-icon")
                                            }
                                        }
                                        Divider()
                                            .padding(.top)
                                        
                                    }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
            Spacer()
            
            NavigationLink(destination: AddVehicle()) {
                Image("add-icon")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        
        .onAppear {
            apiMethod.myVehicle()
        }
    }
}

struct MyVehicles_Previews: PreviewProvider {
    static var previews: some View {
        MyVehicles()
    }
}
