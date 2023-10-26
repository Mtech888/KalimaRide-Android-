//
//  detailData.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 27/09/2023.
//

import SwiftUI

struct RecurringDetailData: View {
    var rideDate: String
    var leavingTime: String
    var returnigTime: String
    var numberOfSeats: Int
    var duration: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Date")
                        .font(.custom(Font.medium, size: 14))
                    HStack(spacing: 12) {
                        Image("calender-icon")
                        Text(rideDate)
                    }
                    .font(.custom(Font.regular, size: 13))
                }
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("Leaving At")
                        .font(.custom(Font.medium, size: 14))
                    HStack(spacing: 12) {
                        Image("clock-icon")
                        Text(leavingTime)
                    }
                    .font(.custom(Font.regular, size: 13))
                }
                
                HStack(spacing: 12) {
                    Image("seats-icon")
                    Text("\(numberOfSeats) Seats Available")
                }
                .font(.custom(Font.regular, size: 13))
            }
            
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading, spacing: 14) {
                    Text("duration")
                        .font(.custom(Font.medium, size: 14))
                    HStack(spacing: 12) {
                        Image("calender-icon")
                        Text(duration)
                    }
                    .font(.custom(Font.regular, size: 13))
                }
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("Returning at (same day)")
                        .font(.custom(Font.medium, size: 14))
                    HStack(spacing: 12) {
                        Image("clock-icon")
                        Text(returnigTime)
                    }
                    .font(.custom(Font.regular, size: 13))
                }
            }
        }
    }
}

struct RecurringDetailData_Previews: PreviewProvider {
    static var previews: some View {
        RecurringDetailData(rideDate: "", leavingTime: "", returnigTime: "", numberOfSeats: 0, duration: "")
    }
}
