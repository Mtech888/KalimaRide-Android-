//
//  StopoverLocation.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 06/09/2023.
//

import SwiftUI

struct StopoverLocation: View {
    var image: String = ""
    var title: String =  ""
    @State var minusStepper: String?
    @State var price: Int?
    @State var addStepper: String?
    
    var body: some View {
        HStack(spacing: 2) {
            HStack(spacing: 14) {
                Image(image)
                
                Text(title)
                    .font(.custom(Font.regular, size: 15))
                    .frame(width: UIScreen.main.bounds.width * 0.5, alignment: .leading)
            }

            Spacer()
            
            HStack(spacing: 10) {
                if let minusStepper = minusStepper {
                    Button {
                        
                    } label: {
                        Image(minusStepper)
                    }
                }
                
                if let price = price {
                    Text("$\(price)")
                        .font(.custom(Font.medium, size: 17))
                }
                
                if let addStepper = addStepper {
                    Button {
                        
                    } label: {
                        Image(addStepper)
                    }
                }
            }
        }
        Divider()
    }
}

struct StopoverLocation_Previews: PreviewProvider {
    static var previews: some View {
        StopoverLocation()
    }
}
