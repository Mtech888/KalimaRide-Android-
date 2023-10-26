//
//  EditProfile.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 23/08/2023.
//

import SwiftUI
import PhotosUI
import Combine
import CountryPicker

struct EditProfile: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject private var imagePicker = PhotoPicker()
    @StateObject var updateProfileApi = UpdateProfileApiMethod()
    @EnvironmentObject var userDataApi: LoadUserDataAPIMethod
    @State private var selectCountry: Country? = nil
    @State private var showPicker = false
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()},
                         title: "Edit Profile",
                         icon: "back-icon",
                         hiddenTitle: "Title")
            .background(
                Color.white.shadow(color: Color.black.opacity(0.1),
                                   radius: 5,
                                   x: 0,
                                   y: 5)
            )
            .padding(.top)
            
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 140, height: 113)
                        .shadow(color: Color.black.opacity(0.2),
                                radius: 5,
                                y: 5)
                    if let image = imagePicker.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 101, height: 101)
                            .clipShape(Circle())
                    } else {
                        Image("placeholder-image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 121, height: 101)
                            .clipShape(Circle())
                    }
                    
                    PhotosPicker(selection: $imagePicker.imageSelection,
                                 matching: .images) {
                        Image("camera-picker-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 40)
                            .padding(.top, 100)
                            .padding(.leading, 70)
                    }
                }
            }
            .padding(.top)
            
            VStack(spacing: 25) {
                
                CustomTextFeild(fieldBinding: $updateProfileApi.firstName,
                                title: "FIRST NAME",
                                placeholder: "John")
                
                CustomTextFeild(fieldBinding: $updateProfileApi.lastName,
                                title: "LAST NAME",
                                placeholder: "Smith")
                
                VStack(alignment: .leading) {
                    Text("PHONE NUMBER")
                        .font(.custom(Font.regular, size: 13))
                        .foregroundColor(.primary)
                    HStack(spacing: 16) {
                        Button {
                            showPicker = true
                        } label: {
                            Text("+" + updateProfileApi.countryCode)
                        }.sheet(isPresented: $showPicker) {
                            CountryPicker(country: $selectCountry)
                                .onCountrySelected { country in
                                    updateProfileApi.countryCode = country.phoneCode
                                }
                        }
                        
                        TextField("Type Here", text: $updateProfileApi.phoneNumber)
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
            }
            .padding(.horizontal)
            .padding(.top, 90)
            
            CustomButton(action: {updateProfileApi.updateProfile()},
                         title: "Save",
                         background: Color.theme.appColor,
                         foreground: .white)
            .padding(.top)
            .alert(isPresented: $updateProfileApi.showAlert) {
                Alert(title: Text(updateProfileApi.alertTitle),
                      message: Text(updateProfileApi.alertMessage),
                      dismissButton: .default(Text("OK"))
                )
            }
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
