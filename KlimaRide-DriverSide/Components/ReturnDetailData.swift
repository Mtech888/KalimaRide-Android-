//
//  ReturnDetailData.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 27/09/2023.
//

import SwiftUI

struct ReturnDetailData: View {
    var leavingDate: String
    var leavingTime: String
    var returningDate: String
    var returningTime: String
    var numberOfSeats: Int
    
    var body: some View {
        VStack(alignment:.leading, spacing: 24){
            VStack(alignment: .leading, spacing: 14) {
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
                        Image("clock-icon")
                        Text(leavingTime)
                            .font(.custom(Font.regular, size: 13))
                    }
                    Spacer()
                }
            }
            
            VStack(alignment: .leading, spacing: 14) {
                Text("Returning Date")
                    .font(.custom(Font.medium, size: 14))
                
                HStack(spacing: 16) {
                    HStack {
                        Image("calender-icon")
                        Text(returningDate)
                            .font(.custom(Font.regular, size: 13))
                    }
                    Text("At")
                        .font(.custom(Font.regular, size: 14))
                    HStack {
                        Image("clock-icon")
                        Text(returningTime)
                            .font(.custom(Font.regular, size: 13))
                    }
                    Spacer()
                }
            }
            
            HStack {
                Image("seats-icon")
                Text("\(numberOfSeats) Seats Available")
                    .font(.custom(Font.regular, size: 13))
            }
        }
    }
}

struct ReturnDetailData_Previews: PreviewProvider {
    static var previews: some View {
        ReturnDetailData(leavingDate: "", leavingTime: "", returningDate: "", returningTime: "", numberOfSeats: 0)
    }
}
