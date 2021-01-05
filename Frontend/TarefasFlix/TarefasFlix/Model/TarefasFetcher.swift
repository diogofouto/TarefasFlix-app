//
//  TarefasFetcher.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 03/01/2021.
//

import Foundation
import Combine

public class TarefasFetcher: ObservableObject {
    var person: String
    @Published var tarefas = [Tarefa]()
    
    init(_ person: String){
        self.person = person
        load()
    }
    
    func load(){
        // Set POST method & endpoint url
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/household-chores-app/backend.cgi/listarTarefasPorFilho") else {
            print("Error: invalid API endpoint")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create POST json data
        let postData: [String: Any] = ["filho": "\(self.person)"]
        let postJson: Data
        do {
            postJson = try JSONSerialization.data(withJSONObject: postData)
            request.httpBody = postJson
        } catch {
            print("Error: cannot create JSON from Data")
            return
        }
        
        // POST connect: send request and get response
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let d = data {
                    // Decode json response and assign tarefas to tarefas
                    if let JSONString = String(data: d, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                    let response = try JSONDecoder().decode([Tarefa].self, from: d)
                    DispatchQueue.main.async {
                        self.tarefas = response
                    }
                } else {
                    print("No Data in response")
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
}
