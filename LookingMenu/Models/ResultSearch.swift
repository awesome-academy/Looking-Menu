import Foundation

struct ResultSearch: Codable {
    let results: [Recipe]
    let totalResults: Int
}

extension ResultSearch: Equatable {
    static func == (lhs: ResultSearch, rhs: ResultSearch) -> Bool {
        return lhs.totalResults == rhs.totalResults
            && lhs.results == rhs.results
    }
}
