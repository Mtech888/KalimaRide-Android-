//
//  Return.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 06/09/2023.
//

import SwiftUI

struct SearchReturn: View {
    @StateObject var searchPost = SearchPostAPiMethod()
    
    var body: some View {
        VStack(spacing: 20) {
            CustomTextFeild(fieldBinding: $searchPost.eventNameField, title: "Name of the Event", placeholder: "Type Here")
            
            CustomTextFeild(fieldBinding: $searchPost.departureField, title: "City of Departure", placeholder: "Type Here")
            
            CustomTextFeild(fieldBinding: $searchPost.arrivalField, title: "City of Arrival", placeholder: "Type Here")
            CustomTextFeild(fieldBinding: $searchPost.dateField, title: "Date", placeholder: "Select Date", icon: "date-icon")
        }
        .padding(.top)
        
        CustomButton(action: {
            searchPost.twoWayRide()

        },
                     title: "Search",
                     background: Color.theme.appColor,
                     foreground: .white)
        .padding(.top)
        .disabled(searchPost.searchPost)
        .alert(isPresented: $searchPost.showAlert) {
            Alert(title: Text(searchPost.alertTitle),
                  message: Text(searchPost.alertMessage),
                  dismissButton: .default(Text("OK"))
            )
        }
        
        NavigationLink(destination: SearchDetails(searchDetails: searchPost).environmentObject(searchPost),
                       isActive: $searchPost.searchPost,
                       label: {
            EmptyView()
        })
        .hidden()
        
        .padding(.top)
    }
}

struct SearchReturn_Previews: PreviewProvider {
    static var previews: some View {
        let mockSearchRide = SearchPostAPiMethod()
             mockSearchRide.eventNameField = "Sample Event"
             
        return SearchReturn(searchPost: mockSearchRide)
    }
}
