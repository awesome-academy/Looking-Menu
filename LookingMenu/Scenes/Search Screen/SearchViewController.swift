import UIKit

private enum ConstantSearchView {
    static let radiusView: CGFloat = 20
    static let constantAnchor: CGFloat = 4
    static let multipleCollectionSize: CGFloat = 2.5
}

enum TypeSearch {
    case searchName
    case searchIngredient
}

final class SearchViewController: UIViewController {
    @IBOutlet private weak var labelKeyWordSearch: UILabel!
    @IBOutlet private weak var slideView: UIView!
    @IBOutlet private weak var viewRecipeNotFound: UIStackView!
    @IBOutlet private weak var labelTotalResult: UILabel!
    @IBOutlet private weak var resultSearchCollection: UICollectionView!
    @IBOutlet private weak var constrantBottomSlideView: NSLayoutConstraint!
    let idResultSearchCell = "ResultSearchCell"
    var keyWord : String = ""
    var typeSearch = TypeSearch.searchName
    var listResultSearchByName = [Recipe]()
    var listResultSearchByIngredients = [ResultSearchByIngredients]()
    var sizeSeachCellCollection = (width: CGFloat(),
                                   height: CGFloat())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSearchView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sizeSeachCellCollection.height =
            view.frame.height / ConstantSearchView.multipleCollectionSize
        sizeSeachCellCollection.width =
            view.frame.width / ConstantSearchView.multipleCollectionSize
    }
    
    private func configSearchView() {
        if typeSearch == .searchName {
            APIRecipe.apiRecipe.searchRecipeByName(query: keyWord) { [unowned self] result in
                DispatchQueue.main.async {
                    self.listResultSearchByName = result.results
                    self.labelTotalResult.text = "Found \(result.totalResults) results"
                    self.viewRecipeNotFound.isHidden = result.totalResults != 0
                    self.resultSearchCollection.isHidden = result.totalResults == 0
                    self.resultSearchCollection.reloadData()
                    self.finishSearchingRecipe()
                }
            }
        } else {
            APIRecipe.apiRecipe.searchRecipesByIngredient(ingredients: keyWord) { [unowned self] result in
                DispatchQueue.main.async {
                    listResultSearchByIngredients = result
                    labelTotalResult.isHidden = true
                    self.viewRecipeNotFound.isHidden = result.count != 0
                    self.resultSearchCollection.isHidden = result.count == 0
                    self.resultSearchCollection.reloadData()
                    self.finishSearchingRecipe()
                }
            }
        }
        setUpCollectionViewItemLayout()
        labelKeyWordSearch.text = keyWord
        slideView.layer.cornerRadius = ConstantSearchView.radiusView
    }
    
    private func setUpCollectionViewItemLayout() {
        let customLayout = CustomSearchCollectionViewLayout()
        customLayout.delegate = self
        resultSearchCollection.register(ResultSearchCell.self,
                                        forCellWithReuseIdentifier: idResultSearchCell)
        resultSearchCollection.collectionViewLayout = customLayout
    }
    
    func finishSearchingRecipe() {
        constrantBottomSlideView.constant = ConstantSearchView.constantAnchor
        UIView.animate(withDuration: 1.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func goBackHomeView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return typeSearch == .searchName ? listResultSearchByName.count
            : listResultSearchByIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = resultSearchCollection.dequeueReusableCell(withReuseIdentifier: idResultSearchCell, for: indexPath) as? ResultSearchCell
        else { return UICollectionViewCell() }
        if typeSearch == .searchName {
            let item = listResultSearchByName[indexPath.row]
            cell.configSearchCell(image: String(format: UrlAPIRecipe.urlImageRecipe,
                                                item.image),
                                  title: item.title,
                                  minute: "\(item.readyInMinutes) Minute")
        } else {
            let item = listResultSearchByIngredients[indexPath.row]
            cell.configSearchCell(image: item.image,
                                  title: item.title,
                                  minute: "Like : \(item.likes)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = StoryBoardReference.detail.storyBoard.instantiateViewController(withIdentifier: IdStoryBoardViews.detailRecipeVC)
                as? DetailRecipeController else { return }
        detailVC.recipe = typeSearch == .searchName
            ? listResultSearchByName[indexPath.row]
            : Recipe (
                id: listResultSearchByIngredients[indexPath.row].id,
                title: listResultSearchByIngredients[indexPath.row].title,
                readyInMinutes: listResultSearchByIngredients[indexPath.row].likes,
                image: listResultSearchByIngredients[indexPath.row].image)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: CustomSearchDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        sizeRecipeItem indexPath: IndexPath) -> CGSize {
        return CGSize(width: sizeSeachCellCollection.width,
                      height: sizeSeachCellCollection.height)
    }
}
