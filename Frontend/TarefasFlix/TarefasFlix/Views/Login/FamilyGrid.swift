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
                    let handler = AssignmentsHandler(person.name)
                    NavigationLink(destination: AssignmentList(handler: handler)) {
                        PersonThumbnail(name: person.name)
                            .padding()
                    }
                }
                // If supervisor, show news
                else {
                    let fetcher = NewsFetcher(person.name)
                    NavigationLink(destination: NewsList(fetcher: fetcher)) {
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
