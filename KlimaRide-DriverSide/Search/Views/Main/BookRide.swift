//
//  BookRide.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/09/2023.
//

import SwiftUI

struct BookRide: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var seatsField: String = ""
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @State var menuOpened = false
    @StateObject var bookRideApi =  BookRideApiMethod()
    @State var switchView = false
    @EnvironmentObject var postDetailsApi: PostDetailsApiMethod
    
    var body: some View {
        VStack {
            if switchView {
                withAnimation(Animation.linear.delay(5)) {
                    TabBar()
                }
            } else {
                BookRideView
            }
        }
    }
    
    struct BookRide_Previews: PreviewProvider {
        static var previews: some View {
            BookRide()
        }
    }
    
    @ViewBuilder
    private var BookRideView : some View {
        ZStack {
            VStack {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "Book Ride", icon: "back-icon", hiddenTitle: "Title")
                    .background(
                        Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    )
                    .padding(.top)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("How many Seats you want?")
                            .font(.custom(Font.medium, size: 20))
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading) {
                            Text("Seats Available")
                                .font(.custom(Font.regular, size: 13))
                                .foregroundColor(.primary)
                            
                            HStack {
                                TextField("type Here", value: $bookRideApi.seats, format: .number)
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
                        
                        //                        .padding(.top)
                        
                        // Map Integration
                        Group {
                            Text("Pickup Point")
                                .font(.custom(Font.medium, size: 20))
                                .foregroundColor(.primary)
                            
                            MapView(places: $places)
                                .frame(height: 150)
                                .cornerRadius(10)
                        }
                        
                        Text("Payment Details")
                            .font(.custom(Font.medium, size: 20))
                            .foregroundColor(.primary)
                        
                        VStack(spacing: 20) {
                            HStack{
                                Text("Seat price")
                                    .foregroundColor(.primary)
                                    .font(.custom(Font.regular, size: 15))

                                
                                Spacer()
                                
                                Text("$ \(bookRideApi.seatPrice)")
                                    .foregroundColor(.primary)
                                    .font(.custom(Font.regular, size: 15))

                            }
                            .padding(.horizontal, 30)
                            
                            HStack{
                                Text("No Of Seats")
                                    .foregroundColor(.primary)
                                    .font(.custom(Font.regular, size: 15))

                                
                                Spacer()
                                
                                Text("\(bookRideApi.noOfSeats)")
                                    .foregroundColor(.primary)
                                    .font(.custom(Font.regular, size: 15))

                            }
                            .padding(.horizontal, 30)
                            
                            HStack{
                                Text("SubTotal")
                                    .foregroundColor(.primary)
                                    .font(.custom(Font.medium, size: 15))

                                Spacer()
                                
                                Text("$ \(bookRideApi.noOfSeats * bookRideApi.seats)")
                                    .foregroundColor(.primary)
                                    .font(.custom(Font.medium, size: 15))

                            }
                            .padding(.horizontal, 30)
                        }
                        .font(.custom(Font.regular, size: 14))
                    }
                    .padding()
                    
                    CustomButton(action: {
                        bookRideApi.bookRide()
                        withAnimation(.easeInOut) {
                            menuOpened.toggle()
                        }
                    }, title: "Send Request", background: Color.theme.appColor, foreground: .white)
                    .padding(.top)
                    .padding(.bottom, 10)
                    
                    Spacer()
                }
            }
            .onAppear() {
                bookRideApi.bookRide()
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            
            Receipt(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, menuOpened: menuOpened, toggleMenu: {
                if menuOpened {
                    switchView = true
                } else {
                    switchView = false
                }
            })
        }
    }
    
}
