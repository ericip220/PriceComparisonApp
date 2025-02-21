//
//  ProductCardView.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 07/02/2025.
//

import SwiftUI

struct ProductCardView: View {
    var product: Product
    
    var body: some View {
        HStack {
            Image(systemName: "cart")
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.6))
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text(product.brand)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                ForEach(product.prices.keys.sorted(), id: \.self) { key in
                    Text("\(key): £\(product.prices[key]!, specifier: "%.2f")")
                        .foregroundColor(key == "Tesco" ? .green : .orange)
                }
                Button(action: {
                    // Add to list action
                }) {
                    Image(systemName: "cart.badge.plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor (.red)
                }
            }
            Spacer()
        }
        .padding()
        //.background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 30)
        .padding(.horizontal)
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: Product(name: "Organic Milk", brand: "Brand A", prices: ["Tesco": 1.20, "Sainsbury's": 1.15], imageUrl: "https://pics.freeicons.io/uploads/icons/png/340631961655107260-64.png"))
    }
}

