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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MealsView(viewModel: MealsViewModel())
}
