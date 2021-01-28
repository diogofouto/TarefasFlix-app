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
                if (person != "") {
                    if (person == "Pai" || person == "Mãe") {
                        let handler = NewsHandler(supervisor: person, password: "0000")
                        Login(handler: handler)
                    }
                    else {
                        let handler = AssignmentsHandler(person)
                        AssignmentList(handler: handler)
                    }
                }
                LoginScreen()
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
