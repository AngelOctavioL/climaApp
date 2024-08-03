//
//  ModelLocationData.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import Foundation

// Función para cargar datos desde un archivo JSON
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Cannot find \(filename) in bundle")
    }
    
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Couldn't load data from file \(filename)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse the file data")
    }
}
