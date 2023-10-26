//
//  RestaurantDetails.swift
//  KlimaRideApp
//
//  Created by Mtechsoft on 15/08/2023.
//

import SwiftUI

struct RestaurantDetails: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let restaurant: Restaurant
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "Details", icon: "back-icon", hiddenTitle: "Title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                ).padding(.top)
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    ZStack(alignment: .topTrailing) {
                        if let photoReference = restaurant.photoReference {
                            PhotoView(photoReference: photoReference)
                        } else {
                            Image("RestaurantImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        
                        VStack {
                            HStack {
                                Text("\(restaurant.rating, specifier: "%.1f")")
                                    .fontWeight(.medium)
                                
                                Image("starIcon")
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(30)
                        }
                        .padding()
                        
                        
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(restaurant.name)
                            .font(.custom(Font.bold, size: 20))
                        
                        HStack {
                            Image("location")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 15, height: 15)
                            
                            Text(restaurant.address)
                                .font(.custom(Font.regular, size: 12))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(.custom(Font.medium, size: 14))
                        
                        Text("Brown the beef better. Lean ground beef – I like to use 85% lean angus. Garlic – use fresh  chopped. Spices – chili powder, cumin, onion powder.")
                            .font(.custom(Font.regular, size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Website")
                            .font(.custom(Font.medium, size: 14))
                        
                        Text("www.xn--mcdonalds-nb0e.com")
                            .font(.custom(Font.medium, size: 15))
                            .foregroundColor(Color.theme.appColor)
                            .underline()
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

//struct RestaurantDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantDetails()
//    }
//}
