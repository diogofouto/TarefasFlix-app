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
        VStack {
            Spacer()
            Text("Brevemente!")
            Spacer()
        }
    }
}

struct ScoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScoreScreen()
    }
}
