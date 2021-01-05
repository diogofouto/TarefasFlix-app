//
//  ContentView.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 30/12/2020.
//

import SwiftUI

struct ContentView: View {
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorColor = .clear
    }
    @State var showMainView: Bool = false
    
    var body: some View {
        VStack{
            if self.showMainView
            {
                // show the principal page
                LoginScreen()
            }
            else
            {
                // show the Splash Screen
                Image("TarefasFlix Logo")
            }
        }
        .onAppear {
            // after three seconds, system will change the value of the
            // showMainView variable
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.showMainView = true
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
