//
//  NewsHandler.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 03/01/2021.
//

import Foundation
import Combine
import UIKit

public class NewsHandler: ObservableObject {
    var supervisor: String
    @Published var news = [News]()
    
    init(_ supervisor: String){
        self.supervisor = supervisor
        load()
    }
    
    func load(){
        // Prepare POST request
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/TarefasFlix/backend.cgi/listNews") else {
            print("Error: invalid API endpoint")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create & add JSON to request
        let postData: [String: Any] = ["supervisor": "\(self.supervisor)"]
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
                    let response = try JSONDecoder().decode([News].self, from: d)
                    DispatchQueue.main.sync {
                        self.news = response
                    }
                } else {
                    print("No Data in response")
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func checkNews(_ id: Int){
        // Prepare POST request
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/TarefasFlix/backend.cgi/checkNews") else {
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
        
        var backgroundTask = 0
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroundTask") { UIApplication.shared.endBackgroundTask(UIBackgroundTaskIdentifier(rawValue: backgroundTask))
        backgroundTask = UIBackgroundTaskIdentifier.invalid.rawValue }.rawValue
        
        // Send request and get response
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let d = data {
                    // Decode json response and assign tarefas
                    if let JSONString = String(data: d, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                    let response = try JSONDecoder().decode([News].self, from: d)
                    DispatchQueue.main.sync {
                        self.news = response
                    }
                } else {
                    print("No Data in response")
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func forceAssignment(news_id: Int, assignment_id: Int){
        // Prepare POST request
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/TarefasFlix/backend.cgi/forceAssignment") else {
            print("Error: invalid API endpoint")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create & add JSON to request
        let postData: [String: Any] = ["news_id": "\(news_id)", "assignment_id": "\(assignment_id)"]
        let postJson: Data
        do {
            postJson = try JSONSerialization.data(withJSONObject: postData)
            request.httpBody = postJson
        } catch {
            print("Error: cannot create JSON from Data")
            return
        }
        
        var backgroundTask = 0
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroundTask") { UIApplication.shared.endBackgroundTask(UIBackgroundTaskIdentifier(rawValue: backgroundTask))
        backgroundTask = UIBackgroundTaskIdentifier.invalid.rawValue }.rawValue
        
        // Send request and get response
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let d = data {
                    // Decode json response and assign tarefas
                    if let JSONString = String(data: d, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                    let response = try JSONDecoder().decode([News].self, from: d)
                    DispatchQueue.main.sync {
                        self.news = response
                    }
                } else {
                    print("No Data in response")
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
    func forgetAssignment(news_id: Int, assignment_id: Int){
        // Prepare POST request
        guard let url = URL(string: "http://web2.ist.utl.pt/ist193705/TarefasFlix/backend.cgi/forgetAssignment") else {
            print("Error: invalid API endpoint")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create & add JSON to request
        let postData: [String: Any] = ["news_id": "\(news_id)", "assignment_id": "\(assignment_id)"]
        let postJson: Data
        do {
            postJson = try JSONSerialization.data(withJSONObject: postData)
            request.httpBody = postJson
        } catch {
            print("Error: cannot create JSON from Data")
            return
        }
        
        var backgroundTask = 0
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroundTask") { UIApplication.shared.endBackgroundTask(UIBackgroundTaskIdentifier(rawValue: backgroundTask))
        backgroundTask = UIBackgroundTaskIdentifier.invalid.rawValue }.rawValue
        
        // Send request and get response
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let d = data {
                    // Decode json response and assign tarefas
                    if let JSONString = String(data: d, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                    let response = try JSONDecoder().decode([News].self, from: d)
                    DispatchQueue.main.sync {
                        self.news = response
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
