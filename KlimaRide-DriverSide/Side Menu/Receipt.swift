//
//  PublishedSuccessfully.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 07/09/2023.
//

import SwiftUI

struct Receipt: View {
    let width: CGFloat
    let height: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeInOut.delay(0.25))
            .onTapGesture {
                toggleMenu()
            }
            
            VStack {
                VStack(spacing: 30) {
                    Image("request-page-image")
                    
                    VStack(alignment: .center, spacing: 20) {
                        Text("Your Request Has Been Sent Successfully!")
                            .font(.custom(Font.medium, size: 20))
                        Text("We Will Notify You When Driver Is Accepted Your Request")
                            .padding(.horizontal, 40)
                            .font(.custom(Font.regular, size: 12))
                    }
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding(.top)
                }
                .frame(height: UIScreen.main.bounds.height * 0.7)
            }
            .background(Color.white)
            .cornerRadius(10)
            .frame(width: width, height: height)
            .offset(y: menuOpened ? 0 : -height)
            .animation(.default)
        }
    }
}

struct Receipt_Previews: PreviewProvider {
    static var previews: some View {
        Receipt(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, menuOpened: true, toggleMenu: {})
    }
}
