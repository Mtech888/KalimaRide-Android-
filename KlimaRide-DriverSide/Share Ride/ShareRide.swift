//
//  PostRide.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct ShareRide: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    @State private var selectedRideTabs: ShareRideTabs = .oneWay
    
    var body: some View {
        VStack {
            CustomNavbar(title: "Share Ride", hiddenTitle: "Title" )
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Ride Type")
                    .font(.custom(Font.medium, size: 13))
                ShareRideFilter(selectedTab: $selectedRideTabs)
            }
            .padding(.top, 25)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    if selectedRideTabs == .oneWay {
                        OneWayRide()
                    }else if selectedRideTabs == .returns {
                        ReturnRide()
                    }else if selectedRideTabs == .recurring {
                        RecurringRide()
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct ShareRide_Previews: PreviewProvider {
    static var previews: some View {
        ShareRide()
    }
}


struct ShareRideFilter: View {
    @Binding var selectedTab: ShareRideTabs
    
    var body: some View {
        HStack {
            ForEach(ShareRideTabs.allCases, id: \.rawValue) { item in
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
