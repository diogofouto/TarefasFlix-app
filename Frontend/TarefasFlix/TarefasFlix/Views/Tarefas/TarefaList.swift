//
//  TarefaList.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct TarefaList: View {
    var fetcher: TarefasFetcher
    //@ObservedObject var fetcher = TarefasFetcher("Diogo")
    
    var body: some View {
        List(fetcher.tarefas) { tarefa in
            Spacer()
            TarefaCard(tarefa: tarefa)
            Spacer()
        }
    }
}

struct TarefaList_Previews: PreviewProvider {
    static var previews: some View {
        TarefaList(fetcher: TarefasFetcher("Diogo"))
    }
}
