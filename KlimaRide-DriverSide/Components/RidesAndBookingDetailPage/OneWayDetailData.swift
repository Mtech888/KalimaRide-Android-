//
//  OneWayDetailData.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 27/09/2023.
//

import SwiftUI

struct OneWayDetailData: View {
    var leavingDate: String
    var leavingTime: String
    var numberOfSeats: Int
    
    var body: some View {
        VStack(alignment:.leading, spacing: 26){
            Text("Leaving Date")
                .font(.custom(Font.medium, size: 14))
            
            HStack(spacing: 16) {
                HStack {
                    Image("calender-icon")
                    Text(leavingDate)
                        .font(.custom(Font.regular, size: 13))
                }
                Text("At")
                    .font(.custom(Font.regular, size: 14))
                HStack {
                    Image("time-icon")
                    Text(leavingTime)
                        .font(.custom(Font.regular, size: 13))
                }
                Spacer()
            }
            
            HStack {
                Image("seats-icon")
                Text("\(numberOfSeats) Seats Available")
                    .font(.custom(Font.regular, size: 13))
            }
        }
    }
}

struct OneWayDetailData_Previews: PreviewProvider {
    static var previews: some View {
        OneWayDetailData(leavingDate: "", leavingTime: "", numberOfSeats: 0)
    }
}
