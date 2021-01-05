//
//  TarefaFamilyLoader.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import Foundation
import Combine

public class FamilyLoader: ObservableObject {
    @Published var family = [Person]()
    
    init(){
        load()
    }
    
    func load() {
        let data: Data

        guard let file = Bundle.main.url(forResource: "familyData.json", withExtension: nil)
        else {
            fatalError("Couldn't find familyData.json in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load familyData.json from main bundle:\n\(error)")
        }

        do {
            self.family = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            fatalError("Couldn't parse familyData.json: \(error)")
        }
    }
}
