//
//  Tarefa.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import Foundation
import SwiftUI

struct News: Hashable, Codable, Identifiable {
    var id: Int
    var assignment_id: Int
    var task: String
    var agent: String
    var message: String
    var news_date: String
    var supervisor: String
    var status: String
}
