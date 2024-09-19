//
//  ContentView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import SwiftUI

struct ContentView: View {
    
    let services: MealsService = MealsServiceImpl()
    
    var body: some View {
        MealsView(viewModel: MealsViewModel(services: services))
    }
}

#Preview {
    ContentView()
}
