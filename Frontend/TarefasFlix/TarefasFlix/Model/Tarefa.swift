//
//  Tarefa.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import Foundation
import SwiftUI

struct Tarefa: Hashable, Codable, Identifiable {
    var id: Int
    var tarefa: String
    var filho: String
    var data_registo: String
    var data_conclusao: String
    var supervisor: String
    var status: String
    var recompensa: String!
}
