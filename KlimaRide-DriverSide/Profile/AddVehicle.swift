//
//  UpdateVehicleInformation.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 23/08/2023.
//

import SwiftUI

struct AddVehicle: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var addVehicle = AddVehicleApiMethod()
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()},
                         title: "Vehicle Information",
                         icon: "back-icon",
                         hiddenTitle: "Title")
            .background(
                Color.white.shadow(color: Color.black.opacity(0.1),
                                   radius: 5,
                                   x: 0,
                                   y: 5)
            )
            
            VStack {
                CustomTextFeild(fieldBinding: $addVehicle.brandName,
                                title: "BRAND NAME",
                                placeholder: "Select One Option",
                                icon: "down-icon")
                
                VStack(alignment: .leading) {
                    Text("MODEL NAME")
                        .font(.custom(Font.regular, size: 13))
                        .foregroundColor(.primary)
                    
                    HStack {
                        TextField("Enter Your Vehicle Model Name",
                                  value: $addVehicle.modelName,
                                  format: .number)
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
                
                CustomTextFeild(fieldBinding: $addVehicle.numberPlate,
                                title: "NUMBER PLATE",
                                placeholder: "Enter Your Vehicle Number Plate")
            }
            .padding(.top)
            
            CustomButton(action: {addVehicle.addVehicle()},
                         title: "Save",
                         background: Color.theme.appColor,
                         foreground: .white)
            .padding(.top)
            .alert(isPresented: $addVehicle.showAlert) {
                Alert(title: Text(addVehicle.alertTitle),
                      message: Text(addVehicle.alertMessage),
                      dismissButton: .default(Text("OK"))
                )
            }
            Spacer()
        }
        .padding()
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct AddVehicle_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicle()
    }
}
