//
//  HomeView.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 07/02/2025.
//

import SwiftUI

// Ensure productList is declared at the top level
let productList = [
    Product(name: "[8% 回贈] $350 Price 網購禮券 |$2...", brand: "Brand A", prices: ["Store1": 9898.0]),
    Product(name: "Medicube Age-R Booster Pro 智慧...", brand: "Brand B", prices: ["Store2": 1450.0]),
    Product(name: "Samsung 三星 B-Series 2.1ch Soun...", brand: "Brand C", prices: ["Store3": 388.0])
]


struct HomeView: View {
    @State private var searchText = ""
    @State private var filteredProducts: [Product] = productList
    
    var body: some View {
        
        NavigationView {
            ZStack {
                // Background Image
                Image("back2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    // Custom search bar with microphone and magnifying glass icons
                    SearchBar(searchText: $searchText, onSearch: performSearch)
                    
                    VStack(alignment: .center) {
                        CategoryIcons()
                        DealsCarousel()
                        
                        // Display filtered products
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Search Results")
                                .font(.headline)
                                .padding(.leading, 20)
                            ForEach(filteredProducts, id: \.id) { product in
                                HStack {
                                    // Product image
                                    Image(systemName: "photo") // Replace with actual image name
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .padding(.leading, 20)
                                    // Product details
                                    VStack(alignment: .leading) {
                                        Text(product.name)
                                            .font(.body)
                                        Text("HK$ \(product.prices.values.first ?? 0.0)")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                        Text("Original: HK$ \(product.prices.values.first ?? 0.0)")
                                            .font(.footnote)
                                            .strikethrough()
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                            }
                        }
                    }
                }
            }
        }
    }

    // Search function to filter the products based on the search text
    func performSearch() {
        if searchText.isEmpty {
            filteredProducts = productList
        } else {
            filteredProducts = productList.filter { product in
                product.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
