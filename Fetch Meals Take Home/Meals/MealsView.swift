//
//  MealsView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import SwiftUI

struct MealsView: View {
    
    @ObservedObject var viewModel: MealsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Test")
            }
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    MealsView(viewModel: MealsViewModel(services: MealsServiceImpl()))
}
