//
//  ScoreScreen.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 11/02/2021.
//

import SwiftUI

struct ScoreScreen: View {
    @ObservedObject private var handler = AssignmentsHandler("Diogo")
    
    var body: some View {
        VStack {
            if self.handler.scoreHasLoaded {
                Spacer()
                    .frame(height: 125)
                Text("Pontuação")
                    .font(.title)
                    .fontWeight(.light)
                ForEach(self.handler.scores){ score in
                    HStack {
                        PersonImage(name: score.id, width: 50, height: 60)
                        Spacer()
                            .frame(width: 50)
                        Text("\(score.score)")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                        Text("pts")
                    }
                }
            }
            else {
                Text("A carregar pontuação...")
            }
        }
        .onAppear() {
            self.handler.getScores()
        }
    }
}

struct ScoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScoreScreen()
    }
}
