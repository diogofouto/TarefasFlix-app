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
            VStack {
                // Headers
                logo
                    .offset(y: -70)
                HStack {
                    Spacer()
                    Text("Quem está a ver?")
                        .font(.title)
                        .fontWeight(.medium)
                    Spacer()
                }
                .offset(y: -110)
                
                Spacer()
                    .frame(height: 50)
                
                // Show people thumbnails
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(family) { person in
                        // If filho, show tarefas
                        if (person.position == "filho") {
                            let fetcher = TarefasFetcher(person.name)
                            NavigationLink(destination: TarefaList(fetcher: fetcher)) {
                                PersonThumbnail(person: person)
                                    .padding(.bottom)
                            }
                        }
                        // If supervisor, show options
                        else {
                            PersonThumbnail(person: person)
                                .padding(.bottom)
                        }
                    }
                }
                .offset(y: -100)
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
