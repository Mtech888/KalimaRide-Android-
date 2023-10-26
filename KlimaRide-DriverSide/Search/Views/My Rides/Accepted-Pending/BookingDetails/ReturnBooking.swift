//
//  ReturnBooking.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 07/09/2023.
//

import SwiftUI

struct ReturnBooking: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Image("no-bookings-image")
            Text("No Bookings Yet!")
                .font(.custom(Font.regular, size: 20))
            Spacer()
        }
    }
}

struct ReturnBooking_Previews: PreviewProvider {
    static var previews: some View {
        ReturnBooking()
    }
}
