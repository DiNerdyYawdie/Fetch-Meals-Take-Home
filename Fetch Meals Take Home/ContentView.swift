//
//  ContentView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MealsView(viewModel: MealsViewModel())
    }
}

#Preview {
    ContentView()
}
