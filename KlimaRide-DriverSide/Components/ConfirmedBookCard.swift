//
//  ConfirmedBookCard.swift
//  KlimaRideApp
//
//  Created by MAC on 15/08/2023.
//

import SwiftUI

struct ConfirmedBookCard: View {
    var image: String = ""
    var rating: String = ""
    var title: String = ""
    var description: String?
    var distance: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                Image(image)
                HStack(alignment: .center) {
                    Text(rating)
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
                Text(title)
                    .font(.custom(Font.medium, size: 17))
                    .foregroundColor(.black)
                if let description = description {
                    Text(description)
                        .font(.custom(Font.regular, size: 11))
                        .foregroundColor(.black)
                }
                HStack {
                    Image("path-icon")
                    Text(distance)
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

struct ConfirmedBookCard_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmedBookCard()
    }
}
