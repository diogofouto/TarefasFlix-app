//
//  ScoreScreen.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 11/01/2021.
//

import SwiftUI

struct ScoreScreen: View {
    @ObservedObject var handler = AssignmentsHandler("Diogo")
    
    var body: some View {
        NavigationView {
            VStack {
                AssignmentListHeader(handler: handler)
                Spacer()
                Text("Coming soon!")
                Spacer()
                AssignmentListFooter(handler: handler)
            }
            .navigationBarHidden(true)
            .frame(height: 1030)
        }
        .navigationBarHidden(true)
    }
}

struct ScoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScoreScreen()
    }
}
