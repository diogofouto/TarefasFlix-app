//
//  TarefasFlixApp.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 30/12/2020.
//

import SwiftUI

@main
struct TarefasFlixApp: App {
    @StateObject private var familyLoader = FamilyLoader()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(familyLoader)
        }
    }
}
