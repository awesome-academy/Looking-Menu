import Foundation

struct Recipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
            && lhs.image == rhs.image
            && lhs.readyInMinutes == rhs.readyInMinutes
            && lhs.title == rhs.title
    }
}
