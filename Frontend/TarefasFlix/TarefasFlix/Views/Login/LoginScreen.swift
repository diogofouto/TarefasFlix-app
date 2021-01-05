//
//  LoginScreen.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var familyLoader: FamilyLoader
    
    var body: some View {
        List {
            HStack {
                Spacer()
                Text("Quem está a ver as TarefasFlix?")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(familyLoader.family) { person in
                    PersonThumbnail(person: person)
                        .padding(.bottom)
                }
            }
        }
        .offset(y: 80)
        .preferredColorScheme(.dark)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .environmentObject(FamilyLoader())
            //.preferredColorScheme(.dark)
    }
}
