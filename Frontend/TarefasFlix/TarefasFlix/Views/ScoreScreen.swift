//
//  ScoreScreen.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 11/01/2021.
//

import SwiftUI

struct ScoreScreen: View {
    @ObservedObject var handler = AssignmentsHandler("Diogo")
    
    var body: some View {
        NavigationView {
            VStack {
                AssignmentListHeader(handler: handler, toggle: false)
                Spacer()
                Text("Coming soon!")
                Spacer()
                // AssignmentListFooter
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: AssignmentList(handler: handler)) {
                            Image(systemName: "rectangle.stack.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .accentColor(.gray)
                            
                        }
                        Spacer()
                            .frame(width: 50)
                        Divider()
                            .frame(height: 50)
                        Spacer()
                            .frame(width: 50)
                        Image(systemName: "chart.bar.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .accentColor(.gray)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 100)
                    
                }
                .navigationBarHidden(true)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                      opacity: 0.5), lineWidth: 1)
                        .shadow(radius: 3)
                    
                )
            }
            .navigationBarHidden(true)
            .frame(height: 1030)
        }
        .navigationBarHidden(true)
    }
}

struct ScoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScoreScreen()
    }
}
