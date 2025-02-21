import Foundation

struct Product: Identifiable, Codable {
    var id = UUID()
    let name: String
    let brand: String
    var prices: [String: Double]
    let imageUrl: String?
}
