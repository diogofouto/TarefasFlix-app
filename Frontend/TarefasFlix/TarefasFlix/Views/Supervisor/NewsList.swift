//
//  NewsList.swift
//  NewsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct NewsList: View {
    @ObservedObject var handler: NewsHandler
    @State private var showUncheckedOnly: Bool = true
    @State private var reload: Bool = false
    
    var filteredNews: [News] {
        handler.news.filter { news in
            (!showUncheckedOnly || news.status != "visto")
        }
    }
    
    var body: some View {
        NavigationView {
            // News List Header
            VStack {
                VStack {
                    Spacer()
                        .frame(height: 150)
                    HStack {
                        Spacer()
                        NavigationLink(destination: LoginScreen()) {
                            PersonImage(name: handler.supervisor, width: 45, height: 60)
                        }
                        Spacer()
                            .frame(width: 200)
                        Button {
                            handler.load()
                            handler.load()
                            reload = !reload
                        } label: {
                            Image(systemName: "arrow.2.circlepath")
                                .resizable()
                                .frame(width: 30, height: 25)
                                .accentColor(.black)
                        }
                        Spacer()
                        Menu {
                            Toggle(isOn: $showUncheckedOnly) {
                                Text("Mostrar Apenas Notícias Não Vistas")
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .accentColor(.black)
                        }
                        Spacer()
                    }
                    
                }
                .navigationBarHidden(true)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                      opacity: 0.5), lineWidth: 1)
                        .shadow(radius: 3)
                    
                )
                // List
                ScrollView {
                    Spacer()
                        .frame(height: 15)
                    ForEach(filteredNews) { news in
                        Menu {
                            if news.message == "Houve reclamação!" {
                                Button {
                                    handler.forceAssignment(news_id: news.id, assignment_id: news.assignment_id)
                                    handler.load()
                                    reload = !reload
                                } label: {
                                    Text("Manter Tarefa")
                                    Image(systemName: "hand.thumbsup")
                                }
                                Button {
                                    handler.forgetAssignment(news_id: news.id, assignment_id: news.assignment_id)
                                    handler.load()
                                    reload = !reload
                                } label: {
                                    Text("Retirar Tarefa")
                                    Image(systemName: "hand.thumbsdown")
                                }
                            }
                            else if news.status != "visto" {
                                Button {
                                    handler.checkNews(news.id)
                                    handler.load()
                                    reload = !reload
                                } label: {
                                    Text("Marcar como visto")
                                    Image(systemName: "checkmark")
                                }
                            }
                        } label: {
                            VStack {
                                if news.message == "Houve reclamação!" {
                                    Text(news.message)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.sRGB, red: 200/255, green: 0/255, blue: 0/255))
                                }
                                else {
                                    Text(news.message)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.sRGB, red: 0/255, green: 100/255, blue: 255/255))
                                }
                                Divider()
                                VStack {
                                    Text("\(news.task)")
                                        .font(.title3)
                                    HStack {
                                        Text("Por:")
                                            .fontWeight(.light)
                                        Text("\(news.agent)")
                                    }
                                }
                                .font(.body)
                                .foregroundColor(.black)
                            }
                            .padding()
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.5), lineWidth: 1)
                                    .shadow(radius: 3)
                            )
                            .padding([.leading, .bottom, .trailing])
                        }
                    }
                    Spacer()
                        .frame(height: 15)
                }
                .padding([.leading, .trailing])
                // NewsListFooter
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "rectangle.stack.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        Divider()
                            .padding()
                            .frame(height: 50)
                        /*
                        NavigationLink(destination: ScoreScreen(handler: handler)) {
                        }
                        */
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .foregroundColor(.yellow)
                        Divider()
                            .padding()
                            .frame(height: 50)
                        Image(systemName: "chart.bar.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 100)
                    
                }
                .navigationBarHidden(true)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                      opacity: 0.5), lineWidth: 1)
                        .shadow(radius: 3)
                    
                )
            }
            .navigationBarHidden(true)
            .frame(height: 1030)
        }
        .navigationBarHidden(true)
    }
}

struct NewsList_Previews: PreviewProvider {
    @ObservedObject static var handler = NewsHandler("Mãe")
    static var previews: some View {
        NewsList(handler: handler)
    }
}
