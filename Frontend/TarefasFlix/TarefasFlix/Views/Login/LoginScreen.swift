//
//  LoginScreen.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct LoginScreen: View {
    var logo = Image("TarefasFlix Logo")
    var family: [Person] {
        FamilyLoader().family
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                logo
                    .offset(y: -130)
                HStack {
                    Spacer()
                    Text("Quem está a ver?")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .offset(y: -170)
                Spacer()
                    .frame(height: 50)
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(family) { person in
                        let fetcher = TarefasFetcher(person.name)
                            NavigationLink(destination: TarefaList(fetcher: fetcher)) {
                                PersonThumbnail(person: person)
                                    .padding(.bottom)
                            }
                    }
                }
                .offset(y: -170)
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
