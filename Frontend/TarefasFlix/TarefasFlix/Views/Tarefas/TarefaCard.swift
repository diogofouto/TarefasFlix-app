//
//  TarefaCard.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct TarefaCard: View {
    var tarefa: Tarefa
    
    var body: some View {
        VStack {
            Text(tarefa.tarefa)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.sRGB, red: 200/255, green: 0/255, blue: 0/255))
            Divider()
            VStack(alignment: .leading) {
                Text("Por: \(tarefa.supervisor)")
                Text("Até: \(tarefa.data_conclusao)")
                if tarefa.recompensa != nil {
                    Text("Recompensa: \(tarefa.recompensa)")
                }
                Divider()
                HStack {
                    Text("Status:")
                    Text("\(tarefa.status)".capitalized)
                        .font(.title3)
                        .fontWeight(.medium)
                }
            }
            .font(.body)
        }
        .padding()
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255,
                              opacity: 0.5), lineWidth: 1)
                .shadow(radius: 3)
        )
    }
}

struct TarefaCard_Previews: PreviewProvider {
    @ObservedObject static var fetcher = TarefasFetcher("Diogo")
    static var tarefa = fetcher.tarefas[0]
    static var previews: some View {
        TarefaCard(tarefa: tarefa)
    }
}
