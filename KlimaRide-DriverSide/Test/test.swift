//
//  test.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 18/09/2023.
//

import SwiftUI

struct test: View {
    @State private var selectedOption = 0
        let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        VStack {
                  Text("Selected Option: \(options[selectedOption])")

                  Picker("Select an Option", selection: $selectedOption) {
                      ForEach(0 ..< options.count) { index in
                          HStack {
                              Text(options[index])
                              Spacer() // Add spacing here
                              Image(systemName: "chevron.down.circle") // Icon
                          }
                          .tag(index)
                          
                      }
                  }
                  .pickerStyle(MenuPickerStyle()) // This style gives it a down arrow appearance
              }
              .padding()
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}


