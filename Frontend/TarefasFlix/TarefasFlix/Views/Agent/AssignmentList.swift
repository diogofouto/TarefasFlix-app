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
        NavigationView {
            VStack {
                AssignmentListHeader(fetcher: fetcher)
                ScrollView {
                    ForEach(fetcher.assignments) { assignment in
                        AssignmentCard(assignment: assignment)
                    }
                }
                .frame(height: 700)
            }
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct AssignmentList_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentList()
    }
}
