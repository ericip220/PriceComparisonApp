//
//  CategoryIcons.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 09/02/2025.
//
import SwiftUI

struct CategoryIcons: View {
    @State private var icons: [IconItem] = [
        IconItem(name: "Fruits & Veg", systemName: "leaf.fill"),
        IconItem(name: "Dairy", systemName: "cart.fill"),
        IconItem(name: "Meats", systemName: "flame.fill"),
        IconItem(name: "Beverages", systemName: "drop.fill"),
        IconItem(name: "Bakery", systemName: "bag.fill"),
        IconItem(name: "Household", systemName: "house.fill")
    ]

    var body: some View {
        HStack(alignment: .top, spacing: -10) {
            ForEach(icons.indices, id: \.self) { index in
                ButtonWithPressEffect(icon: $icons[index])
            }
        }
    }
}

struct CategoryIcons_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIcons()
    }
}
