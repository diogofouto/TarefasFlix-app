//
//  AssignmentListHeader.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 08/01/2021.
//

import SwiftUI

struct AssignmentListHeader: View {
    @ObservedObject var fetcher = AssignmentsFetcher("Diogo")
    
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: LoginScreen()) {
                PersonImage(name: fetcher.agent, width: 55, height: 70)
                    .offset(y: -25)
            }
            Spacer()
                .frame(width: 180)
            Menu {
                Button {
                } label: {
                    Text("Mostrar apenas 'Por Fazer'")
                    Image(systemName: "tortoise")
                }
                Button {
                } label: {
                    Text("Ordenar por Data")
                    Image(systemName: "calendar")
                }
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .accentColor(.black)
                    .offset(y: -60)
            }
            Spacer()
        }
        .padding()
        .frame(height: -6)
    }
}

struct AssignmentListHeader_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentListHeader()
    }
}
