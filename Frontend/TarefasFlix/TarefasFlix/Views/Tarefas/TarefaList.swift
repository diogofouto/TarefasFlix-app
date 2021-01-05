//
//  TarefaList.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct TarefaList: View {
    @ObservedObject var fetcher = TarefasFetcher()
    
    var body: some View {
        List(fetcher.tarefas) { tarefa in
            VStack (alignment: .leading) {
                Text(tarefa.supervisor)
            }
        }
    }
}

struct TarefaList_Previews: PreviewProvider {
    static var previews: some View {
        TarefaList()
    }
}
