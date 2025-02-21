import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var filteredProducts: [Product] = []
    @State private var products: [Product] = [] // Local storage for products
    
    var body: some View {
        NavigationView {
            VStack {
                // Custom search bar with microphone and magnifying glass icons
                SearchBar(searchText: $searchText, onSearch: performSearch)
                
                List(filteredProducts) { product in
                    VStack(alignment: .leading) {
                        HStack {
                            if let urlString = product.imageUrl, let url = URL(string: urlString) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text("Brand: \(product.brand)")
                                    .font(.subheadline)
                            }
                        }
                        .padding(.bottom, 5)
                        
                        HStack {
                            ForEach(Array(product.prices.keys), id: \.self) { store in
                                VStack {
                                    Text(store)
                                    Text("HK$ \(product.prices[store] ?? 0.0, specifier: "%.2f")")
                                        .foregroundColor(.red)
                                }
                                .padding(5)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
                
                NavigationLink(destination: UserInputForm(products: $products)) {
                    Text("Add Product")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("SuperMarket Price")
        }
    }
    
    func performSearch() {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { product in
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
