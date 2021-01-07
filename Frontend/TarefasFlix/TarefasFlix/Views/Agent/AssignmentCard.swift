//
//  AssignmentCard.swift
//  AssignmentsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct AssignmentCard: View {
    var assignment: Assignment
    
    var body: some View {
        Menu {
            Button {
            } label: {
                Text("Acabei a tarefa!")
                Image(systemName: "checkmark")
            }
            Button {
            } label: {
                Text("Quero mais!")
                Image(systemName: "hare")
            }
        } label: {
            VStack {
                Text(assignment.task)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.sRGB, red: 200/255, green: 0/255, blue: 0/255))
                Divider()
                VStack(alignment: .leading) {
                    Text("Por: \(assignment.supervisor)")
                    Text("Até: \(assignment.deadline_date)")
                    if assignment.reward != nil {
                        Text("Recompensa: \(assignment.reward)")
                    }
                    Divider()
                    HStack {
                        Text("Status:")
                        Text("\(assignment.status)".capitalized)
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                }
                .font(.body)
                .foregroundColor(.black)
            }
            .padding()
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255,
                                  opacity: 0.5), lineWidth: 1)
                    .shadow(radius: 3)
            )
            .padding([.leading, .bottom, .trailing])
        }
        /* PARA FAZER DEBUG NO AssignmentCard!
         VStack {
             Text("Aspirar o Tesla")
                 .font(.title2)
                 .fontWeight(.semibold)
                 .foregroundColor(Color(.sRGB, red: 200/255, green: 0/255, blue: 0/255))
             Divider()
             VStack(alignment: .leading) {
                 Text("Por: Pai")
                 Text("Até: xx-xx-xxxx")
                 Text("Recompensa: Beats me")
                 Divider()
                 HStack {
                     Text("Status:")
                     Text("por fazer".capitalized)
                         .font(.title3)
                         .fontWeight(.medium)
                 }
             }
             .font(.body)
             .foregroundColor(.black)
         }
         */
    }
}

struct AssignmentCard_Previews: PreviewProvider {
    @ObservedObject static var fetcher = AssignmentsFetcher("Diogo")
    static var assignment = fetcher.assignments[0]
    static var previews: some View {
        AssignmentCard(assignment: assignment)
    }
}