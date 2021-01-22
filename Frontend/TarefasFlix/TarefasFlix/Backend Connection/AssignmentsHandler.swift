//
//  AssignmentsHandler.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 03/01/2021.
//

import Foundation
import Combine
import UIKit

public class AssignmentsHandler: ObservableObject {
    var agent: String
    @Published var assignments = [Assignment]()
    
    init(_ agent: String){
        self.agent = agent
        load()
    }
    
    func load(){
        // Prepare POST request
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/TarefasFlix/backend.cgi/listAssignments") else {
            print("Error: invalid API endpoint")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create & add JSON to request
        let postData: [String: Any] = ["agent": "\(self.agent)"]
        let postJson: Data
        do {
            postJson = try JSONSerialization.data(withJSONObject: postData)
            request.httpBody = postJson
        } catch {
            print("Error: cannot create JSON from Data")
            return
        }
        
        // Send request and get response
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let d = data {
                    // Decode json response and assign tarefas
                    if let JSONString = String(data: d, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                    let response = try JSONDecoder().decode([Assignment].self, from: d)
                    DispatchQueue.main.sync {
                        self.assignments = response
                    }
                } else {
                    print("No Data in response")
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func finishAssignment(_ id: Int){
        // Prepare POST request
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/TarefasFlix/backend.cgi/finishAssignment") else {
            print("Error: invalid API endpoint")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create & add JSON to request
        let postData: [String: Any] = ["id": "\(id)"]
        let postJson: Data
        do {
            postJson = try JSONSerialization.data(withJSONObject: postData)
            request.httpBody = postJson
        } catch {
            print("Error: cannot create JSON from Data")
            return
        }
        
        // Send request and get response
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let d = data {
                    // Decode json response and assign tarefas
                    if let JSONString = String(data: d, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                    let response = try JSONDecoder().decode([Assignment].self, from: d)
                    DispatchQueue.main.sync {
                        self.assignments = response
                    }
                } else {
                    print("No Data in response")
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func complainAssignment(_ id: Int){
        // Prepare POST request
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/TarefasFlix/backend.cgi/complainAssignment") else {
            print("Error: invalid API endpoint")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create & add JSON to request
        let postData: [String: Any] = ["id": "\(id)"]
        let postJson: Data
        do {
            postJson = try JSONSerialization.data(withJSONObject: postData)
            request.httpBody = postJson
        } catch {
            print("Error: cannot create JSON from Data")
            return
        }
        
        // Send request and get response
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let d = data {
                    // Decode json response and assign tarefas
                    if let JSONString = String(data: d, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                    let response = try JSONDecoder().decode([Assignment].self, from: d)
                    DispatchQueue.main.sync {
                        self.assignments = response
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
