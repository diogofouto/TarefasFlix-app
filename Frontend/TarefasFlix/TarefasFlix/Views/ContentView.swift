//
//  ContentView.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 30/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoginScreen: Bool = false
    
    // For 1 second, show splash screen. Then, show LoginScreen
    var body: some View {
        VStack {
            if self.showLoginScreen {
                let person = UserDefaults.standard.string(forKey: "person") ?? ""
                if (person == "Pai" || person == "Mãe") {
                    Login(supervisor: person, password: person)
                }
                else if (person == "Diogo" || person == "Francisco" || person == "Joana" || person == "Sofia" || person == "Afonso" || person == "Marta") {
                    AgentScreen(person)
                }
                else {
                    LoginScreen()
                }
            }
            else {
                Image("TarefasFlix Logo")
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
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
