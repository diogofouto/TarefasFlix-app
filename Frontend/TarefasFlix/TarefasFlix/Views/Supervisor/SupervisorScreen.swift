//
//  SupervisorScreen.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 04/02/2021.
//

import SwiftUI

struct SupervisorScreen: View {
    @ObservedObject var handler: NewsHandler
    @State private var showUncheckedOnly: Bool = true
    @State private var showScoreScreen: Bool = false
    @State private var reload: Bool = false
    @State private var reload1: Bool = false
    @State private var reload2: Bool = false
    @State private var reload3: Bool = false
    @State private var reload4: Bool = false
    @State private var dataHasLoaded: Bool = false
    
    @State private var currentNews: Int = 0
    @State private var currentAssignment: Int = 0
    
    @State private var showForm: Bool = false
    
    // For form
    @State var task: String = ""
    //@State var difficulty: String = ""
    @State var agent: String = ""
    @State var start_date: Date = Date()
    @State var deadline_date: Date = Date()
    @State var reward: String = ""
    
    var family: [Person] {
        FamilyLoader().family.filter { person in
            (person.name != "Mãe" && person.name != "Pai")
        }
    }
    
    var filteredNews: [News] {
        handler.news.filter { news in
            (!showUncheckedOnly || news.status != "visto")
        }
    }
    
    init(_ name: String) {
        handler = NewsHandler(name)
    }
    
    var body: some View {
        NavigationView {
            if showForm {
                ZStack {
                    Color(.sRGB, red: 240/255, green: 240/255, blue: 246/255)
                        .ignoresSafeArea()
                    
                    // Form
                    Form {
                        Section(header: Text("Tarefa")) {
                            TextField("Descrição", text: $task)
                            //TextField("Dificuldade", text: $difficulty)
                        }
                        Section(header: Text("Filho")) {
                            Menu {
                                ForEach(family) { person in
                                    Button {
                                        agent = person.name
                                    } label: {
                                        Text(person.name)
                                            .foregroundColor(Color(.sRGB, red: 190/255, green: 190/255, blue: 190/255))
                                    }
                                }
                            } label: {
                                if agent == "" {
                                    TextField("Nome", text: $agent)
                                        .foregroundColor(Color(.sRGB, red: 190/255, green: 190/255, blue: 190/255))
                                }
                                else {
                                    TextField("\(agent)", text: $agent)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        Section(header: Text("Datas")) {
                            DatePicker(selection: $start_date, in: Date()..., displayedComponents: .date) {
                                Text("Começar em...")
                                    .foregroundColor(Color(.sRGB, red: 190/255, green: 190/255, blue: 190/255))
                            }
                            DatePicker(selection: $deadline_date, in: Date()..., displayedComponents: .date) {
                                Text("Completar até...")
                                    .foregroundColor(Color(.sRGB, red: 190/255, green: 190/255, blue: 190/255))
                            }
                        }
                        Section(header: Text("Recompensa")) {
                            TextField("Opcional", text: $reward)
                        }
                    }
                    .padding()
                    .offset(y: 100)
                    .navigationBarHidden(true)

                    // Title
                    Text("Atribuir Tarefa")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(y: -340)

                    // Buttons
                    HStack {
                        Button {
                            self.showForm = false
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(Color(.sRGB, red: 210/255, green: 0/255, blue: 0/255))
                                .foregroundColor(.white)
                                .cornerRadius(100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                                      opacity: 0.5), lineWidth: 1)
                                        .shadow(radius: 5)
                                )
                        }
                        Spacer()
                            .frame(width: 110)
                        if (task == "" || agent == ""){
                            Image(systemName: "paperplane")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255))
                                .foregroundColor(.white)
                                .cornerRadius(100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                                      opacity: 0.5), lineWidth: 1)
                                        .shadow(radius: 5)
                                )
                        }
                        else {
                            Button {
                                handler.createAssignment(task: task, agent: agent, start_date: start_date, deadline_date: deadline_date, reward: reward)
                                self.showForm = false
                            } label: {
                                Image(systemName: "paperplane")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .background(Color(.sRGB, red: 0/255, green: 210/255, blue: 0/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                                          opacity: 0.5), lineWidth: 1)
                                            .shadow(radius: 5)
                                    )
                            }
                        }
                    }
                    .offset(y: 300)
                }
            } else {
                ZStack (alignment: .center) {
                    if showScoreScreen == false {
                        // List
                        if dataHasLoaded {
                            if filteredNews.count == 0 {
                                Text("Não tens notícias!")
                            }
                            else {
                                ScrollView {
                                    Spacer()
                                        .frame(height: 135)
                                    ForEach(filteredNews) { news in
                                        Menu {
                                            if news.message == "Houve reclamação!" {
                                                Button {
                                                    self.currentNews = news.id
                                                    self.currentAssignment = news.assignment_id
                                                    reload2 = !reload2
                                                } label: {
                                                    Text("Manter Tarefa")
                                                    Image(systemName: "hand.thumbsup")
                                                }
                                                Button {
                                                    self.currentNews = news.id
                                                    self.currentAssignment = news.assignment_id
                                                    reload3 = !reload3
                                                } label: {
                                                    Text("Retirar Tarefa")
                                                    Image(systemName: "hand.thumbsdown")
                                                }
                                            }
                                            else if news.status != "visto" {
                                                Button {
                                                    self.currentNews = news.id
                                                    reload4 = !reload4
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
                                                    Spacer()
                                                    HStack {
                                                        Text("Por:")
                                                            .fontWeight(.light)
                                                        Text("\(news.agent)")
                                                    }
                                                    Spacer()
                                                    Text("\(news.news_date)")
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
                                }
                                .padding([.leading, .trailing])
                            }
                        }
                        else {
                            Text("A carregar notícias...")
                        }
                    }
                    else {
                        ScoreScreen()
                    }
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: LoginScreen()) {
                                PersonImage(name: handler.supervisor, width: 45, height: 60)
                            }
                            Spacer()
                                .frame(width: 160)
                            if showScoreScreen == false {
                                Button {
                                    reload1 = !reload1
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
                            }
                            else {
                                Spacer()
                                    .frame(width: 77)
                            }
                            Spacer()
                        }
                        .padding()
                        .navigationBarHidden(true)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                              opacity: 0.5), lineWidth: 1)
                                .shadow(radius: 3)
                            
                        )
                        .background(Color.white)
                        .opacity(1)
                        .padding()
                        Spacer()
                        // Footer
                        HStack {
                            Spacer()
                            Button {
                                showScoreScreen = false
                            } label: {
                                if showScoreScreen == false {
                                    Image(systemName: "rectangle.stack.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                        .accentColor(.black)
                                }
                                else {
                                    Image(systemName: "rectangle.stack.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                        .accentColor(.gray)
                                }
                            }
                            Spacer()
                            Divider()
                                .padding()
                                .frame(height: 50)
                            Button {
                                showForm = true
                            } label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .padding()
                                    .foregroundColor(.yellow)
                            }
                            Divider()
                                .padding()
                                .frame(height: 50)
                            Spacer()
                            Button {
                                showScoreScreen = true
                            } label: {
                                if showScoreScreen == true {
                                    Image(systemName: "chart.bar.fill")
                                        .resizable()
                                        .frame(width: 30 ,height: 30)
                                        .padding()
                                        .accentColor(.black)
                                }
                                else {
                                    Image(systemName: "chart.bar.fill")
                                        .resizable()
                                        .frame(width: 30 ,height: 30)
                                        .padding()
                                        .accentColor(.gray)
                                }
                            }
                            Spacer()
                        }
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                              opacity: 0.5), lineWidth: 1)
                                .shadow(radius: 3)
                            
                        )
                        .background(Color.white)
                        .opacity(1)
                        .padding()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear() {
            dataHasLoaded = false
            UserDefaults.standard.set(self.handler.supervisor, forKey: "person")
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dataHasLoaded = true
            }
        }
        .onChange(of: reload1, perform: { value in
            dataHasLoaded = false
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dataHasLoaded = true
            }
        })
        .onChange(of: reload2, perform: { value in
            dataHasLoaded = false
            self.handler.forceAssignment(news_id: currentNews, assignment_id: currentAssignment)
            print("Current news: \(currentNews), currentAssignment: \(currentAssignment) ")
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dataHasLoaded = true
            }
        })
        .onChange(of: reload3, perform: { value in
            dataHasLoaded = false
            self.handler.forgetAssignment(news_id: currentNews, assignment_id: currentAssignment)
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dataHasLoaded = true
            }
        })
        .onChange(of: reload4, perform: { value in
            dataHasLoaded = false
            self.handler.checkNews(currentNews)
            print(currentNews)
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dataHasLoaded = true
            }
        })
    }
}

struct SupervisorScreen_Previews: PreviewProvider {
    static var previews: some View {
        SupervisorScreen("Mãe")
    }
}
