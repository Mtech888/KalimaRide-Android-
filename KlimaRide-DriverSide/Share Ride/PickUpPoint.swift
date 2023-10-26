//
//  PickupPoint.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 23/08/2023.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct PickeUpPoint: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            VStack {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "", icon: "back-icon", hiddenTitle: "Title")
                    .padding(.top)
                
                Text("Where would you like to pick up passengers?")
                    .font(.custom(Font.medium, size: 26))
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Image("search-icon")
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.2), radius: 5, y: 5)
                .padding()
            }
            
            ZStack(alignment: .bottom) {
                
                NavigationLink {
                    AddStopover()
                } label: {
                    CustomButton(action: {}, title: "Next", background: Color.theme.appColor, foreground: .white)
                        .padding(.bottom, 40)
                }

                
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }}

struct PickeUpPoint_Previews: PreviewProvider {
    static var previews: some View {
        PickeUpPoint()
    }
}

