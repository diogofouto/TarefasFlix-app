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
                    Button {
                        UserDefaults.standard.set(person.name, forKey: "person")
                        let person1 = UserDefaults.standard.string(forKey: "person") ?? ""
                        print("This is \(person1)")
                    } label: {
                        NavigationLink(destination: AssignmentList(handler: handler)) {
                            PersonThumbnail(name: person.name)
                                .padding()
                        }
                    }
                }
                // If supervisor, show news
                else {
                    let handler = NewsHandler(supervisor: person.name, password: person.password)
                    Button {
                        UserDefaults.standard.set(person.name, forKey: "person")
                    } label: {
                        NavigationLink(destination: Login(handler: handler)) {
                            PersonThumbnail(name: person.name)
                                .padding()
                        }
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
