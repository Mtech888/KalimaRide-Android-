//  RideDetail.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/09/2023.
//

import SwiftUI

struct RideDetail: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var apiMethod = MyVehicleApiMethod()
    @StateObject var deleteVehicle = DeleteVehicleApiMethod()
    @State var myVehicle: [VehicleData]?
    @EnvironmentObject var ridePostApi: RidePostApiMethod
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "", icon: "back-icon")
            VStack(alignment: .leading) {
                Text("Which car are you driving?")
                    .font(.custom(Font.medium, size: 26))
                
                NavigationLink(destination: CustomController().environmentObject(ridePostApi)) {
                    HStack {
                        VStack(alignment: .leading ,spacing: 5) {
                            if let myVehicleModel = apiMethod.myVehicleModel {
                                if myVehicleModel.status {                      ForEach(myVehicleModel.data ?? [], id: \.id) { vehicleData in
                                    HStack {
                                        VStack(alignment: .leading ,spacing: 5) {
                                            Text("\(vehicleData.brandName) \(vehicleData.modelName)")
                                                .font(.custom(Font.regular, size: 16))
                                                .foregroundColor(.black)
                                            Text(vehicleData.numberPlate)
                                                .padding(8)
                                                .font(.custom(Font.regular, size: 12))
                                                .foregroundColor(.black)
                                                .background(Color.theme.bgColor)
                                        }
                                        Spacer()
                                        Image("rightIcon")
                                    }
                                    Divider()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
            apiMethod.myVehicle()
        }
    }
}

struct RideDetail_Previews: PreviewProvider {
    static var previews: some View {
        RideDetail()
    }
}

struct CustomController: UIViewControllerRepresentable {
    @EnvironmentObject var ridePostApi: RidePostApiMethod
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomController>) -> UIViewController {
        let storyboard = UIStoryboard(name: "PickupPoint", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "PickupPointVC") as! PickupPointVC
        controller.ridePostApi = self.ridePostApi
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomController>) {
        
    }
}
