//
//  ContentView.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 07/02/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProductViewModel()
    
    var body: some View {
        ZStack {
            // Background Image
            Image("back2")
                .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            HomeView()
                .environmentObject(viewModel)
        }
        //test git connection
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
