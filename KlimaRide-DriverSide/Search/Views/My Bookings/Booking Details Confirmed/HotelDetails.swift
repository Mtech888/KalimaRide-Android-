//
//  HotelsDetails.swift
//  KlimaRideApp
//
//  Created by Mtechsoft on 15/08/2023.
//

import SwiftUI

struct HotelsDetails: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let hotel: Hotel
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "Details", icon: "back-icon", hiddenTitle: "Title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .padding(.top)
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    ZStack(alignment: .topTrailing) {
                        if let photoReference = hotel.photoReference {
                            PhotoView(photoReference: photoReference)
                        } else {
                            Image("RestaurantImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        
                        VStack {
                            HStack {
                                Text("\(hotel.rating, specifier: "%.1f")")
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
                        Text(hotel.name)
                            .font(.custom(Font.bold, size: 20))
                        
                        HStack {
                            Image("location")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 15, height: 15)
                            
                            Text(hotel.address)
                                .font(.custom(Font.regular, size: 12))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(.custom(Font.medium, size: 14))
                        
                        Text("Aston Hotel, Alice Springs NT 0870, Australia is a modern hotel.elegant 5 star hotel overlooking the sea. perfect for a romantic, charming.")
                            .font(.custom(Font.regular, size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    VStack(alignment:.leading) {
                        Text("Preview")
                            .font(.custom(Font.medium, size: 14))
                        
                        HStack {
                            ForEach(0 ..< 3) { item in
                                Image("RestaurantImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 100)
                                .cornerRadius(5)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Website")
                            .fontWeight(.medium)
                        
                        Text("TheAstonVillHotel.com")
                            .font(.custom(Font.medium, size: 15))
                            .foregroundColor(Color.theme.appColor)
                            .underline()
                    }
                    HStack {
                        Text("Find the best deals in")
                        Text("Booking.com")
                            .foregroundColor(.blue)
                    }
                    .font(.custom(Font.medium, size: 15))
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

//struct HotelsDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelsDetails()
//    }
//}
