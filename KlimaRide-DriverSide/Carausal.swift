//
//  Carausal.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 21/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct Carausal: View {
    @ObservedObject var eventBannersApi = EventBannerApiMethod() // Initialize your API
        
        var body: some View {
            AutoScroller(imageNames: [eventBannersApi.eventImage])
                .onAppear {
                    eventBannersApi.eventbanner()
                }
        }
}

struct Carausal_Previews: PreviewProvider {
    static var previews: some View {
        Carausal()
    }
}

struct AutoScroller: View {
    var imageNames: [String]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State private var selectedImageIndex: Int = 0

    var body: some View {
        ZStack {
            Color.secondary.ignoresSafeArea()
            TabView(selection: $selectedImageIndex) {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    ZStack(alignment: .topLeading) {
                        WebImage(url: URL(string: imageNames[index])) // Load images from URLs
                            .resizable()
                            .tag(index)
                            .frame(width: 350, height: 200)
                    }
//                    .background(Color.black.opacity(0.2))
                    .shadow(radius: 20)
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()

            HStack {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    Capsule()
                        .fill(Color.white.opacity(selectedImageIndex == index ? 1 : 0.33))
                        .frame(width: 35, height: 8)
                        .onTapGesture {
                            selectedImageIndex = index
                        }
                }
                .offset(y: 130)
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                selectedImageIndex = (selectedImageIndex + 1) % imageNames.count
            }
        }
    }
}
