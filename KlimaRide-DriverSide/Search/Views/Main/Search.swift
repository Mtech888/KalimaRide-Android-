//
//  Search.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct Search: View {
    @State private var currentIndex: Int = 1
        @GestureState private var dragOffset: CGFloat = 1
        private let image: [String] = [
            "lg-ballons-image", "lg-ballons-image", "lg-ballons-image", "lg-ballons-image"
        ]
        @EnvironmentObject var appState: AppState
        @State var isViewActive: Bool = false
        @StateObject var viewModel = ContentViewModel()
        @State private var selectedRideFilter: SearchBookingTabs = .oneWay
        @StateObject var searchRide: SearchPostAPiMethod
        @StateObject var eventBannersApi = EventBannerApiMethod()
        @State private var eventBannerModel: EventBannerModel?
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                
                VStack {
                    AutoScroller(imageNames: [eventBannersApi.eventImage])
                        .onAppear {
                            eventBannersApi.eventbanner()
                        }                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hi Jhon,")
                        .foregroundColor(.primary)
                        .font(.custom(Font.regular, size: 16))
                    
                    Text("Where do you wanna go?")
                        .font(.custom(Font.medium, size: 26))
                        .foregroundColor(.primary)
                }
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text("Ride Type")
                        .font(.custom(Font.medium, size: 13))
                        .padding(.top, 10)
                    
                    SearchFilterView(selectedTab: $selectedRideFilter)
                    
                    if selectedRideFilter == .oneWay {
                        SearchOneWay()
                    }else if selectedRideFilter == .returns {
                        SearchReturn()
                    }else if selectedRideFilter == .recurring {
                        SearchRecurring()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            eventBannersApi.eventbanner()
        }
        .navigationBarHidden(true)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        let mockSearchDetails = SearchPostAPiMethod()
        mockSearchDetails.firstName = "John"
        
        return Search(searchRide: mockSearchDetails)
    }
}

struct SearchFilterView: View {
    @Binding var selectedTab: SearchBookingTabs
    
    var body: some View {
        HStack {
            ForEach(SearchBookingTabs.allCases, id: \.rawValue) { item in
                Text(item.title)
                    .font(.custom(Font.medium, size: 13))
                    .foregroundColor(selectedTab == item ? .white : .primary)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 40)
                    .background(selectedTab == item ? Color.theme.appColor : Color.white)
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            self.selectedTab = item
                        }
                    }
            }
        }
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(radius: 1 )
        .padding(.top)
    }
}
