//
//  AssignmentForm.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 22/01/2021.
//

import SwiftUI

struct AssignmentForm: View {
    @State var task: String = ""
    @State var difficulty: String = ""
    @State var agent: String = ""
    @State var start_date: Date = Date()
    @State var deadline_date: Date = Date()
    @State var reward: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Tarefa")) {
                        TextField("Descrição", text: $task)
                        TextField("Dificuldade", text: $difficulty)
                    }
                    Section(header: Text("Filho")) {
                        TextField("Nome", text: $agent)
                    }
                    Section(header: Text("Datas")) {
                        DatePicker(selection: $start_date, in: Date()..., displayedComponents: .date) {
                            Text("Começar...")
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
                .navigationBarHidden(true)
                .frame(height:1000)
                .offset(y: 150)
                // Buttons
                HStack {
                    NavigationLink(destination: ScoreScreen()) {
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
                    NavigationLink(destination: ScoreScreen()) {
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
                .background(Color(.sRGB, red: 240/255, green: 240/255, blue: 246/255))
                .navigationBarHidden(true)
                .offset(y: -160)
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct AssignmentForm_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentForm()
    }
}
