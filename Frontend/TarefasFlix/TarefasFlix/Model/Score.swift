//
//  Person.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import Foundation
import SwiftUI

struct Score: Hashable, Codable, Identifiable {
    var id: String
    var position = UUID()
    var score: Int
    
    enum CodingKeys: String, CodingKey {
            case id = "name"
            case score = "score"
        }
}
