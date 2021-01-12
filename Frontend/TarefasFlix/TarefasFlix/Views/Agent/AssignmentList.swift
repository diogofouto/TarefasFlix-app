//
//  AssignmentList.swift
//  AssignmentsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct AssignmentList: View {
    @ObservedObject var handler: AssignmentsHandler
    @State private var showUnfinishedOnly: Bool = true
    @State private var reload: Bool = false
    
    var filteredAssignments: [Assignment] {
        handler.assignments.filter { assignment in
            (!showUnfinishedOnly || assignment.status != "feito")
        }
    }
    
    var body: some View {
        NavigationView {
            // Assignment List Header
            VStack {
                VStack {
                    Spacer()
                        .frame(height: 150)
                    HStack {
                        Spacer()
                        NavigationLink(destination: LoginScreen()) {
                            PersonImage(name: handler.agent, width: 45, height: 60)
                        }
                        Spacer()
                            .frame(width: 200)
                        Button {
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
                    ForEach(filteredAssignments) { assignment in
                        Menu {
                            if assignment.status != "feito" {
                                Button {
                                    handler.finishAssignment(assignment.id)
                                    reload = !reload
                                } label: {
                                    Text("Acabei a tarefa!")
                                    Image(systemName: "checkmark")
                                }
                                if assignment.status != "em consideração" {
                                    Button {
                                        handler.complainAssignment(assignment.id)
                                        reload = !reload
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
                                    if assignment.reward != nil {
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
                                    .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255,
                                                  opacity: 0.5), lineWidth: 1)
                                    .shadow(radius: 3)
                            )
                            .padding([.leading, .bottom, .trailing])
                        }
                    }
                    Spacer()
                        .frame(height: 15)
                }
                .padding([.leading, .trailing])
                // AssignmentListFooter
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "rectangle.stack.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        Spacer()
                            .frame(width: 50)
                        Divider()
                            .frame(height: 50)
                        Spacer()
                            .frame(width: 50)
                        NavigationLink(destination: ScoreScreen(handler: handler)) {
                            Image(systemName: "chart.bar.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .accentColor(.gray)
                        }
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
    
    func changeAssignmentStatus(id: Int, status: String){
        reload = !reload
    }
}

struct AssignmentList_Previews: PreviewProvider {
    @ObservedObject static var handler = AssignmentsHandler("Diogo")
    static var previews: some View {
        AssignmentList(handler: handler)
    }
}
