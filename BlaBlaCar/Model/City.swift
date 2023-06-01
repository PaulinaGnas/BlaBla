
import Foundation

struct City: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}
