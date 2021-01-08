//
//  PersonProfile.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct PersonThumbnail: View {
    var name: String
    
    var body: some View {
        VStack {
            PersonImage(name: "\(name)")
            Text(name)
                .fontWeight(.regular)
                .foregroundColor(.black)
            Spacer()
        }
        .frame(width: 100, height: 100)
    }
}

struct PersonThumbnail_Previews: PreviewProvider {
    static var family = FamilyLoader().family
    
    static var previews: some View {
        PersonThumbnail(name: "Sofia")
    }
}
