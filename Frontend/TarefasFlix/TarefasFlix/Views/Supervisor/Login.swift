//
//  Login.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 28/01/2021.
//

import SwiftUI

struct Login: View {
    @State var password: String = ""
    @ObservedObject var handler: NewsHandler
    @State var isCreated = false
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center) {
                // Background Color
                Color(.sRGB, red: 240/255, green: 240/255, blue: 246/255)
                    .ignoresSafeArea()
                
                // Form
                Form {
                    TextField("Password", text: $password)
                        .keyboardType(.numberPad)
                }
                .padding()
                .padding(.horizontal)
                .offset(y: 320)
                .navigationBarHidden(true)
                
                VStack {
                    Image("TarefasFlix Logo")
                        .offset(y: -300)
                }
                
                // Profile
                PersonThumbnail(name: handler.supervisor)
                    .padding()
                    .offset(y: -130)
                
                // Buttons
                HStack {
                    NavigationLink(destination: LoginScreen()) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255))
                            .foregroundColor(.white)
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                                  opacity: 0.5), lineWidth: 1)
                                    .shadow(radius: 5)
                            )
                    }
                    Spacer()
                        .frame(width: 110)
                    if (password != handler.password){
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255))
                            .foregroundColor(.white)
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                                  opacity: 0.5), lineWidth: 1)
                                    .shadow(radius: 5)
                            )
                    }
                    else {
                        NavigationLink(destination: NewsList(handler: handler), isActive: $isCreated) {
                            Button {
                                self.isCreated = true
                            } label: {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .background(Color(.sRGB, red: 0/255, green: 210/255, blue: 0/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                                          opacity: 0.5), lineWidth: 1)
                                            .shadow(radius: 5)
                                    )
                            }
                        }
                    }
                }
                .offset(y: 300)
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct Login_Previews: PreviewProvider {
    @ObservedObject static var handler = NewsHandler(supervisor: "Mãe", password: "0000")
    static var previews: some View {
        Login(handler: handler)
    }
}
