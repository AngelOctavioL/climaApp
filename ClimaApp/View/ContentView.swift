//
//  ContentView.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CitiesList()
                .navigationTitle("Cities")
        }
    }
}

#Preview {
    ContentView()
}
