import Foundation
import UIKit

final class SearchViewMirror: MirrorObject {
    init(searchView: SearchViewController) {
        super.init(refrecting: searchView)
    }
    
    var labelTotalResult: UILabel? {
        return extract()
    }
    
    var resultSearchCollection: UICollectionView? {
        return extract()
    }
    
    var viewRecipeNotFound: UIStackView? {
        return extract()
    }
    
    var labelKeyWordSearch: UILabel? {
        return extract()
    }
}
