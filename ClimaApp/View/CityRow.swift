//
//  CityRow.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import SwiftUI

struct CityRow: View {
    let city: City
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(city.nombre)
                .font(.title)
            Spacer()
            Image("\(city.nombre)")
                .resizable()
                .frame(width: 80, height: 50)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CityRow(city: City(id: 1, nombre: "London"))
}
