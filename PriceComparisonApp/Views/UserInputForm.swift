import SwiftUI

struct UserInputForm: View {
    @State private var name = ""
    @State private var brand = ""
    @State private var supermarket = ""
    @State private var price: Double? = nil
    @State private var imageUrl = ""
    @Binding var products: [Product]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Name", text: $name)
                    TextField("Brand", text: $brand)
                }
                
                Section(header: Text("Supermarket and Price")) {
                    TextField("Supermarket", text: $supermarket)
                    TextField("Price", value: $price, formatter: NumberFormatter())
                }
                
                Section(header: Text("Image URL")) {
                    TextField("Image URL", text: $imageUrl)
                }
                
                Button(action: addProduct) {
                    Text("Add Product")
                }
            }
            .navigationTitle("Add Product")
        }
    }
    
    func addProduct() {
        guard let price = price else { return }
        let newProduct = Product(
            name: name,
            brand: brand,
            prices: [supermarket: price],
            imageUrl: imageUrl.isEmpty ? nil : imageUrl
        )
        products.append(newProduct)
        // You can save to a remote server or local database here
    }
}

struct UserInputForm_Previews: PreviewProvider {
    static var previews: some View {
        UserInputForm(products: .constant([]))
    }
}
//
//  Untitled.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 14/02/2025.
//

