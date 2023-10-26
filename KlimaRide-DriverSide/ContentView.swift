//
//  ContentView.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                if UserDefaults.standard.splashSaved {
                    SignIn()
                } else {
                    Splash()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
