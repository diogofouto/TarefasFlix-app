//
//  TarefaCard.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct TarefaCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("Aspirar o Tesla")
                Text("Até: 12-12-2021")
            }
            HStack {
                Text("Comer chocolate")
                Text("...")
            }
        }
        .padding()
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255,
                              opacity: 0.5), lineWidth: 1)
        )
        
    }
}

struct TarefaCard_Previews: PreviewProvider {
    static var previews: some View {
        TarefaCard()
    }
}
