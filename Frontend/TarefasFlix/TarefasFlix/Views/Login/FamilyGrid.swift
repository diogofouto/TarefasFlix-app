//
//  FamilyGrid.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 08/01/2021.
//

import SwiftUI

struct FamilyGrid: View {
    var family: [Person] {
        FamilyLoader().family
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(family) { person in
                // If agent, show assignments
                if (person.position == "agent") {
                    NavigationLink(destination: AgentScreen(person.name)) {
                        PersonThumbnail(name: person.name)
                            .padding()
                    }
                }
                // If supervisor, show news
                else {
                    NavigationLink(destination: Login(supervisor: person.name, password: person.password)) {
                        PersonThumbnail(name: person.name)
                            .padding()
                    }
                }
            }
        }
    }
}

struct FamilyGrid_Previews: PreviewProvider {
    static var previews: some View {
        FamilyGrid()
    }
}
