//
//  PersonImage.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct PersonImage: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .frame(width: 75, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color("accentColor"), lineWidth: 3))
            .shadow(radius: 4)
    }
}

struct PersonImage_Previews: PreviewProvider {
    static var previews: some View {
        PersonImage(image: Image("Sofia"))
    }
}
