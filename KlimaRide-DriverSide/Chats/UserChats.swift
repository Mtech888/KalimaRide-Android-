//
//  UserChats.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct UsersChats: View {
    @State var chatField: String = ""
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        VStack{
            VStack {
                HStack(spacing: 20) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back-icon")
                    }
                    
                    Image("profilePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                    
                    Text("John Smith")
                        .font(.custom(Font.medium, size: 16))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 35)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.12)
            .background(
                Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            )
            .padding(.top)
            
            ScrollView {
                VStack{
                    Text("Today")
                        .font(.custom(Font.medium, size: 11))
                    VStack (alignment: .leading, spacing: 20) {
                            HStack(alignment: .bottom, spacing: 15){
                                Image("profilePic")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom, 25)
        
                                VStack(alignment: .leading) {
                                    VStack {
                                        Text("Hi Cassie! Would you be availablefor a coffee next week, ")
                                            .font(.custom(Font.regular, size: 12))
                                            .padding()
                                    }
                                    .frame(width: UIScreen.main.bounds.width / 1.5)
                                    .background(.white)
                                    .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)
                                    
                                    Text("8:07 PM")
                                        .font(.custom(Font.regular, size: 10))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
            HStack(spacing: 20) {
                
                Button {
                    
                } label: {
                    Image("emoji-icon")
                }
                
                
                TextField("Type something", text: $chatField)
                
                Button {
                    
                } label: {
                    Image("send-icon")
                }
            }
            .padding(25)
            .background(
                Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 0)
            )
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct UsersChats_Previews: PreviewProvider {
    static var previews: some View {
        UsersChats()
    }
}
