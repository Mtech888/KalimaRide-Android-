//
//  Card.swift
//  KlimaRideApp
//
//  Created by MAC on 09/08/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsCard: View {
    @ObservedObject var bookingStatus = BookingStatusChangeApiMethod()
    var bookingData: BookingData?
    var userImage: String = ""
    var name: String = ""
    var date: String = ""
    var time: String = ""
    var availableSeats: String = ""
    var status: String?
    var foregroundColor: Color?
    var backgroundColor: Color?
    var isPendig: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        WebImage(url: URL(string: "\(userImage)"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 39, height: 39)
                            .cornerRadius(50)
                        Text(name)
                            .font(.custom(Font.regular, size: 16))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }

                HStack(spacing: 0) {
                    HStack {
                        Image("calender-icon")
                        Text(date)
                            .font(.custom(Font.regular, size: 11))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    HStack {
                        Image("time-icon")
                        Text(time)
                            .font(.custom(Font.regular, size: 11))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    HStack {
                        Image("seats-icon")
                        Text(availableSeats)
                            .font(.custom(Font.regular, size: 11))
                            .foregroundColor(.primary)
                    }
                }

                if isPendig {
                    HStack(spacing: 20) {
                        Button(action: {
                            if isPendig {
                                bookingStatus.changeStatus(bookingId: bookingData?.id ?? 0, newStatus: "accepted")
                                print(bookingData?.id ?? 0)
                            }
                        }) {
                            Text("Accept")
                                .font(.custom(Font.medium, size: 13))
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.appColor)
                        .cornerRadius(16)

                        Button(action: {
//                            bookingStatus.changeStatus()
                        }) {
                            Text("Reject")
                                .font(.custom(Font.medium, size: 13))
                                .foregroundColor(.red)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay (
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.red, lineWidth: 1.5)
                        )
                    }
                } else {
                    HStack {
                        HStack {
                            if let status = status {
                                Text(status)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 16)
                                    .font(.custom(Font.medium, size: 11))
                                    .foregroundColor(foregroundColor)
                                    .background(backgroundColor)
                                    .cornerRadius(30)
                            }
                        }
                        Spacer()

                            Image("chat-icon")
                                .font(.caption)
                                .foregroundColor(.primary)
                            Text("Message")
                                .foregroundColor(Color.theme.appColor)
                    }
                }
            }
            .padding()
        }
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)

    }
}

//struct DetailsCard_Previews: PreviewProvider {
//    static var previews: some View {
////        DetailsCard(foregroundColor: .white, backgroundColor: .green, isPendig: false)
//    }
//}
