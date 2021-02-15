//
//  ContentView.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 30/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoginScreen: Bool = false
    @State private var showLoginScreen2: Bool = false
    @State private var showWelcome: Bool = true
    
    // For 1 second, show splash screen. Then, show LoginScreen
    var body: some View {
        VStack {
            if self.showLoginScreen {
                let person = UserDefaults.standard.string(forKey: "person") ?? ""
                if (person == "Pai" || person == "Mãe") {
                    SupervisorScreen(person)
                }
                else if (person == "Diogo" || person == "Francisco" || person == "Joana" || person == "Sofia" || person == "Afonso" || person == "Marta") {
                    AgentScreen(person)
                }
                else if showLoginScreen2 {
                    withAnimation {
                        LoginScreen()
                    }
                }
                else {
                    VStack {
                        if self.showWelcome {
                            Image("TarefasFlix Logo")
                            Spacer()
                            withAnimation {
                                Text("Bem vindo ao sonho!")
                                    .font(.title)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            Spacer()
                        }
                        else {
                            Image("TarefasFlix Logo")
                            Spacer()
                            Button {
                                scheduleNotifications()
                            } label: {
                                Spacer()
                                Text("Clica em mim para ligares as notificações")
                                    .multilineTextAlignment(.center)
                                    .font(.title2)
                                    .foregroundColor(Color.black)
                                    .padding()
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(.sRGB, red: 200/255, green: 200/255, blue: 200/255, opacity: 0.5), lineWidth: 1)
                                            .shadow(radius: 3)
                                    )
                                    .padding([.leading, .bottom, .trailing])
                                Spacer()
                            }
                            Spacer()
                            Spacer()
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.showWelcome = false
                            }
                        }
                    }
                }
            }
            else {
                Image("TarefasFlix Logo")
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.showLoginScreen = true
                }
            }
        }
    }
    
    func scheduleNotifications() {
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notificações ativadas!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
            
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.body = "Por favor verifica se tens novo conteúdo!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 14400, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        showLoginScreen2 = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
