//
//  PersonImage.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct PersonImage: View {
    var name: String
    var width1 = 75
    var height1 = 90

    var body: some View {
        Image(name)
            .resizable()
            .frame(width: CGFloat(width1), height: CGFloat(height1), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color("accentColor"), lineWidth: 3))
            .shadow(radius: 4)
    }
}

struct PersonImage_Previews: PreviewProvider {
    static var previews: some View {
        PersonImage(name: "Sofia", width1: 75, height1: 90)
    }
}
