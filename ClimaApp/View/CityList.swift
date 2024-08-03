//
//  CityList.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import SwiftUI
import UIKit

struct CitiesList: View {
    let cities: [City] = load("LocationList.json")
    
    var body: some View {
        List(cities) { city in
            NavigationLink(destination: WrappedUIKitView(city: city)) {
                CityRow(city: city)
            }
        }
    }
}

struct WrappedUIKitView: UIViewControllerRepresentable {
    let city: City

    func makeUIViewController(context: Context) -> DetailsViewController {
        return DetailsViewController(city: city)
    }
    
    func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
    }
}

#Preview {
    CitiesList()
}
