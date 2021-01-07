//
//  AssignmentList.swift
//  AssignmentsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct AssignmentList: View {
    @ObservedObject var fetcher = AssignmentsFetcher("Diogo")
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text("Tarefas")
                    .font(.title)
                    .bold()
                Spacer()
                Menu {
                    Button {
                    } label: {
                        Text("Mudar de utilizador")
                    }
                    Button {
                    } label: {
                        Text("Quero mais!")
                    }
                } label: {
                    PersonImage(name: fetcher.agent, width1: 45, height1: 70)
                }
                .offset(y: -105)
            }
            .padding()
            .offset(y: -120)
            RefreshableScrollView(width: geometry.size.width, height: geometry.size.height, handlePullToRefresh: {
                    self.fetcher.load()
                })
            {
                ForEach(fetcher.assignments) { assignment in
                    AssignmentCard(assignment: assignment)
                }
                .offset(y: -100)
            }
            .offset(y: -100)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct AssignmentList_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentList()
    }
}
