//
//  NewsCard.swift
//  NewsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct NewsCard: View {
    var news: News
    
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
                Text(news.task)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.sRGB, red: 200/255, green: 0/255, blue: 0/255))
                Divider()
                VStack(alignment: .leading) {
                    Text("Por: \(news.supervisor)")
                    Text("Até: \(news.deadline_date)")
                    if news.reward != nil {
                        Text("Recompensa: \(news.reward)")
                    }
                    Divider()
                    HStack {
                        Text("Status:")
                        Text("\(news.status)".capitalized)
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
        /* PARA FAZER DEBUG NO NewsCard!
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

struct NewsCard_Previews: PreviewProvider {
    @ObservedObject static var fetcher = NewsFetcher("Diogo")
    static var news = fetcher.news[0]
    static var previews: some View {
        NewsCard(news: news)
    }
}
