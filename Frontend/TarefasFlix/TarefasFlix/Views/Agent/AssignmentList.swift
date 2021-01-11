//
//  AssignmentList.swift
//  AssignmentsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct AssignmentList: View {
    @ObservedObject var handler = AssignmentsHandler("Diogo")
    
    var body: some View {
        NavigationView {
            VStack {
                AssignmentListHeader(handler: handler)
                ScrollView {
                    Spacer()
                        .frame(height: 15)
                    ForEach(handler.assignments) { assignment in
                        AssignmentCard(assignment: assignment)
                    }
                    Spacer()
                        .frame(height: 15)
                }
                .padding([.leading, .trailing])
                AssignmentListFooter(handler: handler)
            }
            .navigationBarHidden(true)
            .frame(height: 1030)
        }
        .navigationBarHidden(true)
    }
}

struct AssignmentList_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentList()
    }
}
