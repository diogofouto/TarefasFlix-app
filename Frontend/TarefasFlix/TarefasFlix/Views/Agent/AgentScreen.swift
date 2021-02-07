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
                    if handler.dataHasLoaded {
                        ScrollView {
                            Spacer()
                                .frame(height: 135)
                            ForEach(filteredAssignments) { assignment in
                                Menu {
                                    if assignment.status != "feito" {
                                        Button {
                                            handler.finishAssignment(assignment.id)
                                        } label: {
                                            Text("Acabei a tarefa!")
                                            Image(systemName: "checkmark")
                                        }
                                        if assignment.status != "em consideração" {
                                            Button {
                                                handler.complainAssignment(assignment.id)
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
                    else {
                        Text("A carregar tarefas...")
                    }
                }
                else {
                    ScoreScreen(handler: handler)
                }
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: LoginScreen()) {
                            PersonImage(name: handler.agent, width: 45, height: 60)
                        }
                        Spacer()
                            .frame(width: 160)
                        Button {
                            handler.load()
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
            UserDefaults.standard.set(self.handler.agent, forKey: "person")
            self.handler.load()
        }
    }
}

struct AgentScreen_Previews: PreviewProvider {
    static var previews: some View {
        AgentScreen("Diogo")
    }
}
