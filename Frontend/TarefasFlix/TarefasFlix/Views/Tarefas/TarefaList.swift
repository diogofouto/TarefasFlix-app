//
//  TarefaList.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct TarefaList: View {
    //var fetcher: TarefasFetcher
    @ObservedObject var fetcher = TarefasFetcher("Diogo")
    
    var body: some View {
        ScrollView {
            ForEach(fetcher.tarefas) { tarefa in
                TarefaCard(tarefa: tarefa)
                    .padding([.leading, .bottom, .trailing])
                    .onTapGesture {
                        // TODO
                    }
            }
        }
        .padding()
        .offset(y: 5)
        .navigationBarTitle("Tarefas", displayMode: .inline)
    }
}

struct TarefaList_Previews: PreviewProvider {
    static var previews: some View {
        TarefaList()
    }
}
