//
//  Person.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import Foundation
import SwiftUI

struct Person: Hashable, Codable, Identifiable {
    var id: Int
    var name: String

    var image: Image {
        Image(name)
    }
}
