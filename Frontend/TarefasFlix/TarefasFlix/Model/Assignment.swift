//
//  Tarefa.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import Foundation
import SwiftUI

struct Assignment: Hashable, Codable, Identifiable {
    var id: Int
    var task: String
    var agent: String
    var start_date: String
    var deadline_date: String
    var supervisor: String
    var status: String
    var reward: String!
}
