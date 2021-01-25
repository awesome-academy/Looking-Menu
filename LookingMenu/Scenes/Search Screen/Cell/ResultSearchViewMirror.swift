import UIKit

final class ResultSearchViewMirror: MirrorObject {
    init(searchView: ResultSearchCell) {
        super.init(refrecting: searchView)
    }
    
    var titleRecipeLabel: UILabel? {
        return extract()
    }
}
