////
////  Recurring.swift
////  KlimaRide-DriverSide
////
////  Created by MAC on 06/09/2023.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct Recurring: View {
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
//    @State private var userLocation: CLLocationCoordinate2D?
//    @State private var places = [
//        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
//    ]
//    @StateObject var postDetailsApi = PostDetailsApiMethod()
//    
//    var body: some View {
//        ZStack {
//            VStack(spacing: 18) {
//                ScrollView(showsIndicators: false) {
//                    VStack(alignment: .leading, spacing: 20) {
//                        Group {
//                            
//                            HStack {
//                                WebImage(url: URL(string: "\(postDetailsApi.image)"))
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 25, height: 25)
//                                    .cornerRadius(50)
//                                Text(postDetailsApi.firstName + " " + postDetailsApi.lastName)
//                                    .font(.custom(Font.medium, fixedSize: 14))
//                                Spacer()
//                                Text(postDetailsApi.ridetype)
//                                    .padding(6)
//                                    .font(.custom(Font.medium, fixedSize: 14))
//                                    .foregroundColor(Color.theme.appColor)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 5)
//                                            .stroke(Color.theme.appColor, lineWidth: 0.8)
//                                    )
//                            }
//                            
//                            Text(postDetailsApi.rideTitle)
//                                .font(.custom(Font.medium, size: 20))
//                            
//                            HStack {
//                                Text("Price")
//                                    .font(.custom(Font.regular, fixedSize: 11))
//                                Text("$\(postDetailsApi.seatPrice) / Seat")
//                                    .foregroundColor(Color.theme.appColor)
//                                    .font(.custom(Font.bold, fixedSize: 18))
//                            }
//                            
//                            HStack(alignment: .top, spacing: 40) {
//                                VStack(alignment: .leading, spacing: 26) {
//                                    VStack(alignment: .leading, spacing: 14) {
//                                        Text("Date")
//                                            .font(.custom(Font.medium, size: 14))
//                                        HStack(spacing: 12) {
//                                            Image("calender-icon")
//                                            Text(postDetailsApi.rideDate)
//                                        }
//                                        .font(.custom(Font.regular, size: 13))
//                                    }
//                                    
//                                    VStack(alignment: .leading, spacing: 14) {
//                                        Text("Leaving At")
//                                            .font(.custom(Font.medium, size: 14))
//                                        HStack(spacing: 12) {
//                                            Image("clock-icon")
//                                            Text(postDetailsApi.leavingTime)
//                                        }
//                                        .font(.custom(Font.regular, size: 13))
//                                    }
//                                    
//                                    HStack(spacing: 12) {
//                                        Image("seats-icon")
//                                        Text("\(postDetailsApi.availableSeats) Seats Available")
//                                    }
//                                    .font(.custom(Font.regular, size: 13))
//                                }
//                                
//                                VStack(alignment: .leading, spacing: 26) {
//                                    VStack(alignment: .leading, spacing: 14) {
//                                        Text("duration")
//                                            .font(.custom(Font.medium, size: 14))
//                                        HStack(spacing: 12) {
//                                            Image("calender-icon")
//                                            Text("\(postDetailsApi.duration)")
//                                        }
//                                        .font(.custom(Font.regular, size: 13))
//                                    }
//                                    
//                                    VStack(alignment: .leading, spacing: 14) {
//                                        Text("Returning at (same day)")
//                                            .font(.custom(Font.medium, size: 14))
//                                        HStack(spacing: 12) {
//                                            Image("clock-icon")
//                                            Text(postDetailsApi.returningTime)
//                                        }
//                                        .font(.custom(Font.regular, size: 13))
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    
//                    TraverDetails
//                        .padding(.top)
//                    
//                    VStack(alignment:.leading) {
//                        Text("Pickup Point")
//                            .font(.custom(Font.medium, fixedSize: 14))
//                        
//                        MapView(places: $places)
//                            .frame(height: 150)
//                            .cornerRadius(10)
//                    }
//                    .padding(.top, 10)
//                    
//                    Group {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Nearby Restaurants")
//                                .font(.custom(Font.medium, fixedSize: 14))
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 16) {
//                                    NavigationLink(destination: RestaurantDetails()) {
//                                        ConfirmedBookCard(image: "restaurant-image", rating: "4.5", title: "Mcdonalds", distance: "1.2 Km Away")
//                                    }
//                                    ConfirmedBookCard(image: "restaurant-image", rating: "4.5", title: "Mcdonalds", distance: "1.2 Km Away")
//                                }
//                            }
//                        }
//                        .padding(.top)
//                        
//                        VStack(alignment: .leading) {
//                            HStack {
//                                Text("Need A Place To Stay In")
//                                    .font(.subheadline)
//                                Text("Hamburg")
//                                    .font(.subheadline)
//                                    .foregroundColor(Color.theme.appColor)
//                            }
//                            .font(.custom(Font.medium, fixedSize: 14))
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 16) {
//                                    NavigationLink(destination: HotelsDetails()) {
//                                        ConfirmedBookCard(image: "hotel-image", rating: "4.5", title: "The Aston Vill Hotel", description: "Alice Springs NT 0870, Australia", distance: "1.2 Km Away")
//                                    }
//                                    ConfirmedBookCard(image: "hotel-image", rating: "4.5", title: "The Aston Vill Hotel", description: "Alice Springs NT 0870, Australia", distance: "1.2 Km Away")
//                                }
//                            }
//                        }
//                        .padding(.top)
//                    }
//                    
//                    VStack(alignment:.leading) {
//                        HStack {
//                            Text("Find the best deals in")
//                                .font(.subheadline)
//                            Text("Booking.com")
//                                .font(.headline)
//                                .foregroundColor(.blue)
//                                .bold()
//                        }
//                        .padding(.top)
//                        .font(.custom(Font.medium, fixedSize: 14))
//                        
//                        VStack(alignment: .center, spacing: 16) {
//                            NavigationLink(destination: StartRide()) {
//                                CustomButton(action: {},
//                                             title: "Start Ride",
//                                             icon: "track-icon",
//                                             background: Color.theme.appColor,
//                                             foreground: .white)
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding(.bottom)
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                postDetailsApi.showLoader = true
////                postDetailsApi.postDetails()
//            }
//            if postDetailsApi.showLoader {
//                ProgressView()
//                    .foregroundColor(Color.gray)
//            }
//        }
//        .padding()
//        .navigationBarHidden(true)
//    .ignoresSafeArea()
//    }
//}
//
//struct Recurring_Previews: PreviewProvider {
//    static var previews: some View {
//        Recurring()
//    }
//}
//
//extension Recurring {
//    private var TraverDetails: some View {
//        HStack(spacing: 0) {
//            HStack(spacing: 12) {
//                Image("city-icon")
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("City of Departure")
//                    Text(postDetailsApi.departureCity)
//                }
//                .font(.custom(Font.medium, size: 12))
//            }
//            .padding(10)
//            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
//            .overlay {
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.primary, lineWidth: 0.1)
//            }
//            
//            Text("-----")
//                .foregroundColor(Color(.lightGray))
//            
//            HStack(spacing: 12) {
//                Image("city-icon")
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("City of Arrival ")
//                    Text(postDetailsApi.arrivalCity)
//                }
//                .font(.custom(Font.medium, size: 12))
//            }
//            .padding(10)
//            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
//            .overlay {
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.primary, lineWidth: 0.1)
//            }
//        }
//    }
//}
