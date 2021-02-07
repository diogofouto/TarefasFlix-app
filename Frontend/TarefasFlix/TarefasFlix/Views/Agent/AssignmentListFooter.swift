//
//  AssignmentListFooter.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 11/01/2021.
//

import SwiftUI

struct AssignmentListFooter: View {
    @ObservedObject var handler = AssignmentsHandler("Diogo")
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: AssignmentScreen(handler: handler)) {
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
                NavigationLink(destination: ScoreScreen(handler: handler)) {
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                        .accentColor(.gray)
                }
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
}

struct AssignmentListFooter_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentListFooter()
    }
}
