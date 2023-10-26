//
//  CaraouselTest.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 20/09/2023.
//

import SwiftUI

struct CaraouselTest: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let image: [String] = [
    "location", "lock-icon", "lockIcon", "chat-icon"
    ]
    @State var eventBannerData: [EventDetails]
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    ForEach(0..<image.count, id: \.self) { index in
                        Image(image[index])
                            .frame(width: 300, height: 500)
//                            .background(Color.blue)
                            .scaleEffect(currentIndex == index ? 1.2 : 1.8)
                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                    }
//                    ForEach(0..<eventBannerData.count, id: \.self) { item in
//                        Image(eventBannerData[index].eventBanner)
//                            .frame(width: 300, height: 500)
////                            .background(Color.blue)
//                            .scaleEffect(currentIndex == index ? 1.2 : 1.8)
//                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
//                    }
                }
                .gesture(
                    DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(image.count - 1, currentIndex + 1)
                            }
                        }
                    })
                )
            }
            .navigationTitle("Caraousel Test")
        }
    }
}

struct CaraouselTest_Previews: PreviewProvider {
    static var previews: some View {
        CaraouselTest(eventBannerData: [])
    }
}
