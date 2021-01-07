//
//  ContentView.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 30/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State var showLoginScreen: Bool = false
    
    // For 1 second, show splash screen. Then, show LoginScreen
    var body: some View {
        VStack {
            if self.showLoginScreen {
                LoginScreen()
            }
            else {
                Image("TarefasFlix Logo")
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    self.showLoginScreen = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
