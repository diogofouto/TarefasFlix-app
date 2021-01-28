//
//  AssignmentForm.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 22/01/2021.
//

import SwiftUI

struct AssignmentForm: View {
    @State var task: String = ""
    //@State var difficulty: String = ""
    @State var agent: String = ""
    @State var start_date: Date = Date()
    @State var deadline_date: Date = Date()
    @State var reward: String = ""
    
    @ObservedObject var handler: NewsHandler
    var family: [Person] {
        FamilyLoader().family.filter { person in
            (person.name != "Mãe" && person.name != "Pai")
        }
    }
    
    @State var isCreated = false
    
    var body: some View {
        NavigationView {
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
                    NavigationLink(destination: NewsList(handler: handler)) {
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
                        NavigationLink(destination: NewsList(handler: handler), isActive: $isCreated) {
                            Button {
                                handler.createAssignment(task: task, agent: agent, start_date: start_date, deadline_date: deadline_date, reward: reward)
                                self.isCreated = true
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
                }
                .offset(y: 300)
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct AssignmentForm_Previews: PreviewProvider {
    @ObservedObject static var handler = NewsHandler(supervisor: "Mãe", password: "0000")
    static var previews: some View {
        AssignmentForm(handler: handler)
    }
}
