//
//  PersonProfile.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct PersonThumbnail: View {
    var person: Person
    
    var body: some View {
        VStack {
            PersonImage(image: person.image)
            Text(person.name)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(width: 100, height: 100)
    }
}

struct PersonThumbnail_Previews: PreviewProvider {
    static var family = ModelData().family
    
    static var previews: some View {
        PersonThumbnail(person: family[5])
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
