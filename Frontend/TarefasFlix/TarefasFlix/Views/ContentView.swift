//
//  ContentView.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 30/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
