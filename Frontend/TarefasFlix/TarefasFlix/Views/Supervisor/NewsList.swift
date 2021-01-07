//
//  AssignmentList.swift
//  AssignmentsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct NewsList: View {
    @ObservedObject var fetcher = NewsFetcher("Mãe")
    
    var body: some View {
        GeometryReader { geometry in
            RefreshableScrollView(width: geometry.size.width, height: geometry.size.height, handlePullToRefresh: {
                    self.fetcher.load()
                })
            {
                ForEach(fetcher.news) { news in
                    NewsCard(news: news)
                }
                .offset(y: -130)
            }
        }
        .padding()
        .navigationBarTitle("Novidades", displayMode: .inline)
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
