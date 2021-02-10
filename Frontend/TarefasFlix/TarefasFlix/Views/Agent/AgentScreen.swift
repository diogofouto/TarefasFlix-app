//
//  AssignmentScreen.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 04/02/2021.
//

import SwiftUI

struct AgentScreen: View {
    @ObservedObject var handler: AssignmentsHandler
    @State private var showUnfinishedOnly: Bool = true
    @State private var showScoreScreen: Bool = false
    @State private var reload: Bool = false
    @State private var reload1: Bool = false
    @State private var reload2: Bool = false
    @State private var reload3: Bool = false
    @State private var dataHasLoaded: Bool = false
    @State private var scoreHasLoaded: Bool = false
    
    @State private var currentAssignment: Int = 0
    
    var filteredAssignments: [Assignment] {
        handler.assignments.filter { assignment in
            (!showUnfinishedOnly || assignment.status != "feito")
        }
    }
    
    init(_ name: String) {
        self.handler = AssignmentsHandler(name)
    }
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center) {
                if showScoreScreen == false {
                    // List
                    if dataHasLoaded {
                        if filteredAssignments.count == 0 {
                            Text("Não tens tarefas!")
                        }
                        else {
                            ScrollView {
                                Spacer()
                                    .frame(height: 135)
                                ForEach(filteredAssignments) { assignment in
                                    Menu {
                                        if assignment.status != "feito" {
                                            Button {
                                                self.currentAssignment = assignment.id
                                                reload2 = !reload2
                                            } label: {
                                                Text("Acabei a tarefa!")
                                                Image(systemName: "checkmark")
                                            }
                                            if assignment.status != "em consideração" {
                                                Button {
                                                    self.currentAssignment = assignment.id
                                                    reload3 = !reload3
                                                } label: {
                                                    Text("Reclamar")
                                                    Image(systemName: "hand.thumbsdown")
                                                }
                                            }
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
                                                if assignment.reward != "null" {
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
                        Text("A carregar tarefas...")
                    }
                }
                else {
                    if scoreHasLoaded {
                        ScrollView {
                            Spacer()
                                .frame(height: 130)
                            ForEach(handler.scores){ score in
                                HStack {
                                    PersonImage(name: score.id, width: 50, height: 60)
                                        .padding()
                                    Spacer()
                                        .frame(width: 50)
                                    Text("\(score.score)")
                                        .font(.largeTitle)
                                        .fontWeight(.medium)
                                }
                            }
                        }
                    }
                    else {
                        Text("A carregar pontuação...")
                    }
                }
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: LoginScreen()) {
                            PersonImage(name: handler.agent, width: 45, height: 60)
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
                                Toggle(isOn: $showUnfinishedOnly) {
                                    Text("Mostrar Apenas Tarefas Por Fazer")
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
                            .frame(width: 50)
                        Divider()
                            .padding()
                            .frame(height: 50)
                        Spacer()
                            .frame(width: 50)
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
        .navigationBarHidden(true)
        .onAppear() {
            dataHasLoaded = false
            scoreHasLoaded = false
            UserDefaults.standard.set(self.handler.agent, forKey: "person")
            self.handler.load()
            self.handler.getScores()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                dataHasLoaded = true
                scoreHasLoaded = true
            }
        }
        .onChange(of: reload1, perform: { value in
            dataHasLoaded = false
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                dataHasLoaded = true
            }
        })
        .onChange(of: reload2, perform: { value in
            dataHasLoaded = false
            self.handler.finishAssignment(currentAssignment)
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dataHasLoaded = true
            }
        })
        .onChange(of: reload3, perform: { value in
            dataHasLoaded = false
            self.handler.complainAssignment(currentAssignment)
            self.handler.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dataHasLoaded = true
            }
        })
    }
}

struct AgentScreen_Previews: PreviewProvider {
    static var previews: some View {
        AgentScreen("Diogo")
    }
}
