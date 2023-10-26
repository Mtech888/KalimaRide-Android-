//
//  MyRidesDetailPage.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 28/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyRidesDetailPage: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @StateObject var postDetailsApi = PostDetailsApiMethod()
    @State var ridePostData: PostData?
    @State var isButtonEnabled = false
    @State private var selectedFilter: RideTabs = .details
    @ObservedObject var hotelsViewModel = HotelViewModel()
        @ObservedObject var restaurantViewModel = RestaurantViewModel()
        @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            VStack(spacing: 18) {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "Details", icon: "back-icon", hiddenTitle: "Title")
                    .background(
                        Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    )
                
                
                //
                FilterView(selectedTab: $selectedFilter)
                ScrollView(showsIndicators: false) {
                    if selectedFilter == .details {
                        //                    OneWay()
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                
                                HStack {
                                    WebImage(url: URL(string: "\(postDetailsApi.image)"))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .cornerRadius(50)
                                    Text(postDetailsApi.firstName + " " + postDetailsApi.lastName)
                                        .font(.custom(Font.medium, fixedSize: 14))
                                    Spacer()
                                    Text(postDetailsApi.ridetype)
                                        .padding(6)
                                        .font(.custom(Font.medium, fixedSize: 14))
                                        .foregroundColor(Color.theme.appColor)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.theme.appColor, lineWidth: 0.8)
                                        )
                                }
                                
                                Text(postDetailsApi.rideTitle)
                                    .font(.custom(Font.bold, size: 20))
                                
                                HStack {
                                    Text("Price")
                                        .font(.custom(Font.regular, fixedSize: 11))
                                    Text("$\(postDetailsApi.seatPrice) / Seat")
                                        .foregroundColor(Color.theme.appColor)
                                        .font(.custom(Font.bold, fixedSize: 18))
                                }
                                
                                if postDetailsApi.ridetype == "Recurring" {
                                    RecurringDetailData(rideDate: postDetailsApi.rideDate,
                                                        leavingTime: postDetailsApi.leavingTime,
                                                        returnigTime: postDetailsApi.returningTime,
                                                        numberOfSeats: postDetailsApi.availableSeats,
                                                        duration: postDetailsApi.duration)
                                } else if postDetailsApi.ridetype == "Return" {
                                    ReturnDetailData(leavingDate: postDetailsApi.leavingDate,
                                                     leavingTime: postDetailsApi.leavingTime,
                                                     returningDate: postDetailsApi.returningDate,
                                                     returningTime: postDetailsApi.returningTime,
                                                     numberOfSeats: postDetailsApi.availableSeats)
                                } else if postDetailsApi.ridetype == "One Way" {
                                    OneWayDetailData(leavingDate: postDetailsApi.leavingDate,
                                                     leavingTime: postDetailsApi.leavingTime,
                                                     numberOfSeats: postDetailsApi.availableSeats)
                                }
                            }
                        }
                        
                        TraverDetails
                            .padding(.top)
                        
                        VStack(alignment:.leading) {
                            Text("Pickup Point")
                                .font(.custom(Font.medium, fixedSize: 14))
                            
                            MapView(places: $places)
                                .frame(height: 150)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nearby Restaurants")
                                .font(.custom(Font.medium, fixedSize: 14))
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                //                                    NavigationLink(destination: RestaurantDetails()) {
                                                                        nearByRestaurants
                                //                                    }
                                                                }
                            }
                        }
                        .padding(.top)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Need A Place To Stay In")
                                    .font(.subheadline)
                                Text("Hamburg")
                                    .font(.subheadline)
                                    .foregroundColor(Color.theme.appColor)
                            }
                            .font(.custom(Font.medium, fixedSize: 14))
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                //                                    NavigationLink(destination: HotelsDetails()) {
                                                                        nearByHotels
                                //                                    }
                                                                }
                            }
                        }
                        .padding(.top)
                        
                        VStack(alignment:.leading) {
                            HStack {
                                Text("Find the best deals in")
                                    .font(.subheadline)
                                Text("Booking.com")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .bold()
                            }
                            .padding(.top)
                            .font(.custom(Font.medium, fixedSize: 14))
                            
                            VStack(alignment: .center, spacing: 16) {
                                NavigationLink(destination: NewController()) {
                                    CustomButton(action: {},
                                                 title: "Start Ride",
                                                 icon: "track-icon",
                                                 background: Color.theme.appColor,
                                                 foreground: .white)
                                }
                                .disabled(ridePostData?.bookings_count == 0 ? isButtonEnabled : !isButtonEnabled)
                                .opacity(ridePostData?.bookings_count == 0 ? 0.6 : 1)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom)
                                
                            }
                        }
                    } else if selectedFilter == .bookings {
                        VStack(alignment: .leading, spacing: 14) {
                            if let postDetail = postDetailsApi.postDetailsModel {
                                if postDetail.status {
                                    ForEach(postDetail.data?.bookings?.accepted ?? [], id: \.id) { detail in
                                        if detail.status == "accepted" {
                                            DetailsCard(userImage: detail.user_details?.profile_image ?? "",
                                                        name: "\(detail.user_details?.first_name ?? "") \(detail.user_details?.last_name ?? "")",
                                                        date: postDetail.data?.leaving_date ?? "",
                                                        time: postDetail.data?.leaving_time ?? "",
                                                        availableSeats: "\(postDetail.data?.number_of_seats ?? 0) Seat Booked",
                                                        status: detail.status,
                                                        foregroundColor: .white,
                                                        backgroundColor: Color.theme.appColor,
                                                        isPendig: false)
                                        } else if detail.status == "pending" {
                                            DetailsCard(userImage: detail.user_details?.profile_image ?? "",
                                                        name: "\(detail.user_details?.first_name ?? "") \(detail.user_details?.last_name ?? "")",
                                                        date: postDetail.data?.leaving_date ?? "",
                                                        time: postDetail.data?.leaving_time ?? "",
                                                        availableSeats: "\(detail.number_of_seats) Seat Booked",
                                                        status: detail.status, foregroundColor: .white,
                                                        backgroundColor: Color.theme.appColor,
                                                        isPendig: true)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                postDetailsApi.showLoader = true
                postDetailsApi.postDetails(id: ridePostData?.id ?? 0)
                if let userLocation = locationManager.userLocation {
                                    let latitude = userLocation.coordinate.latitude
                                    let longitude = userLocation.coordinate.longitude
                                    let locationString = "\(latitude),\(longitude)"
                                    hotelsViewModel.fetchNearbyHotels(location: locationString, apiKey: "AIzaSyD3u-mlMOBQ8d2zSuqE7ifFxpNxh7VqZQk")
                                    restaurantViewModel.fetchNearbyRestaurants(location: locationString, apiKey: "AIzaSyD3u-mlMOBQ8d2zSuqE7ifFxpNxh7VqZQk")
                                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct MyRidesDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        MyRidesDetailPage()
    }
}

extension MyRidesDetailPage {
    private var TraverDetails: some View {
        HStack(spacing: 0) {
            HStack(spacing: 12) {
                Image("city-icon")
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("City of Departure")
                    Text(postDetailsApi.departureCity)
                }
                .font(.custom(Font.medium, size: 12))
            }
            .padding(10)
            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            
            Text("-----")
                .foregroundColor(Color(.lightGray))
            
            HStack(spacing: 12) {
                Image("city-icon")
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("City of Arrival ")
                    Text(postDetailsApi.arrivalCity)
                }
                .font(.custom(Font.medium, size: 12))
            }
            .padding(10)
            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
        }
    }
}

extension MyRidesDetailPage {
    private var nearByHotels: some View {
        ForEach(hotelsViewModel.hotels, id: \.id) { data in
            NavigationLink(destination: HotelsDetails(hotel: data)) {
                VStack(alignment: .leading) {
                    ZStack(alignment: .topLeading) {
                        if let photoReference = data.photoReference {
                            PhotoView(photoReference: photoReference)
                        } else {
                            Image("hotel-image")
                        }
                        HStack(alignment: .center) {
                            Text("\(data.rating, specifier: "%.1f")")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.black)
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.yellow)
                        }
                        .padding(10)
                        .background(.white)
                        .cornerRadius(30)
                        .padding()
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(data.name)
                            .font(.custom(Font.medium, size: 17))
                            .foregroundColor(.black)
    //                    if let description = description {
                            Text(data.address)
                                .font(.custom(Font.regular, size: 11))
                                .foregroundColor(.black)
    //                    }
                        HStack {
                            Image("path-icon")
                            Text("1.2 Km Away")
                                .font(.custom(Font.regular, size: 11))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 10)
                    .padding(.horizontal)
                }
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)
                .padding(.vertical, 10)

            }
        }
    }
}

extension MyRidesDetailPage {
    private var nearByRestaurants: some View {
        ForEach(restaurantViewModel.restaurants, id: \.id) { data in
            NavigationLink(destination: RestaurantDetails(restaurant: data)) {
                VStack(alignment: .leading) {
                    ZStack(alignment: .topLeading) {
                        if let photoReference = data.photoReference {
                            PhotoView(photoReference: photoReference)
                        } else {
                            Image("hotel-image")
                        }
                        HStack(alignment: .center) {
                            Text("\(data.rating, specifier: "%.1f")")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.black)
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.yellow)
                        }
                        .padding(10)
                        .background(.white)
                        .cornerRadius(30)
                        .padding()
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(data.name)
                            .font(.custom(Font.medium, size: 17))
                            .foregroundColor(.black)
    //                    if let description = description {
    //                        Text(data.address)
    //                            .font(.custom(Font.regular, size: 11))
    //                            .foregroundColor(.black)
    //                    }
                        HStack {
                            Image("path-icon")
                            Text("1.2 Km Away")
                                .font(.custom(Font.regular, size: 11))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 10)
                    .padding(.horizontal)
                }
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)
                .padding(.vertical, 10)

            }
        }
    }
}

struct NewController: UIViewControllerRepresentable {
//    @EnvironmentObject var ridePostApi: RidePostApiMethod
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NewController>) -> UIViewController {
        let storyboard = UIStoryboard(name: "TrackMap", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "TrackMapVC") as! TrackMapVC
//        controller.ridePostApi = self.ridePostApi
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NewController>) {
        
    }
}
