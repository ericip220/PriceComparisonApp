//
//  IconItem.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 09/02/2025.
//


import SwiftUI

struct IconItem: Identifiable {
    let id = UUID()
    let name: String
    let systemName: String
    var isPressed: Bool = false
}