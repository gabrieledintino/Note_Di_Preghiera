//
//  FileManager-Extensions.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 03/10/2020.
//

import Foundation

extension FileManager {
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func getApplicationSupportDirectory() -> URL {
        let paths = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func saveToApplicationSupport<T: Codable>(_ data: T, withName name: String) {
        let url = getApplicationSupportDirectory().appendingPathComponent(name)
        
        do {
            let encoded = try JSONEncoder().encode(data)
            try encoded.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromApplicationSupport<T: Codable>(withName name: String) -> T? {
        let url = getApplicationSupportDirectory().appendingPathComponent(name)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
