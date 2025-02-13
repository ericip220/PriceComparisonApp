//
//  Product.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 07/02/2025.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let prices: [String: Double]
}
