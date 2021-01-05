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
            HStack {
                Text(tarefa.tarefa)
                Text("Até: \(tarefa.data_conclusao)")
            }
            HStack {
                Text("Por: \(tarefa.supervisor)")
                if tarefa.recompensa != nil {
                    Text("Recompensa: \(tarefa.recompensa)")
                }
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
    @ObservedObject static var fetcher = TarefasFetcher("Diogo")
    static var tarefa = fetcher.tarefas[0]
    static var previews: some View {
        TarefaCard(tarefa: tarefa)
    }
}
