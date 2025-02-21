//
//  ProductViewModel.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 07/02/2025.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    init() {
        // Load or fetch product data
        loadProducts()
    }
    
    func loadProducts() {
        // Example products
        products = [
            Product(name: "Organic Milk", brand: "Brand A", prices: ["Tesco": 1.20, "Sainsbury's": 1.15], imageUrl: "https://pics.freeicons.io/uploads/icons/png/340631961655107260-64.png")
        ]
    }
}
