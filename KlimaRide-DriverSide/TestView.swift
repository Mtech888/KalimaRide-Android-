//
//  TestView.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 25/08/2023.
//

import SwiftUI

struct TestView: View {
    @StateObject var viewModel = ContentViewModel()
        
        // MARK: - Body
        
        var body: some View {
            VStack(spacing: 8) {
                Text("Active card is \(viewModel.activeCard)")
                    .font(.system(size: 22))
//                
//                carausel(eventBannnerModel: <#EventBannerModel#>, eventDetails: <#[EventDetails]#>)
                    .environmentObject(viewModel.stateModel)
            } // VStack
            .frame(height: 350, alignment: .center)
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
