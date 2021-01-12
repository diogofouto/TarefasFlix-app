//
//  AssignmentListHeader.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 08/01/2021.
//

import SwiftUI

struct AssignmentListHeader: View {
    @ObservedObject var handler = AssignmentsHandler("Diogo")
    @State var toggle: Bool
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 150)
            HStack {
                Spacer()
                NavigationLink(destination: LoginScreen()) {
                    PersonImage(name: handler.agent, width: 45, height: 60)
                }
                Spacer()
                    .frame(width: 250)
                Menu {
                    Toggle(isOn: $toggle) {
                        Text("Mostrar apenas 'Por Fazer'")
                    }
                    Button {
                    } label: {
                        Text("Ordenar por Data")
                        Image(systemName: "calendar")
                    }
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .accentColor(.black)
                }
                Spacer()
            }
            
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

struct AssignmentListHeader_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentListHeader(toggle: false)
    }
}
