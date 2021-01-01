//
//  Tarefa.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import Foundation
import SwiftUI

struct Tarefa: Hashable, Codable, Identifiable {
    var id:  Int
    var descricao: String
    var dificuldade: Int
    var data_registo: Date
    var data_conclusao: Date
    var supervisor: String
    var status: String
    var recompensa: String
}
