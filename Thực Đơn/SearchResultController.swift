//
//  SearchResultController.swift
//  Thực Đơn
//
//  Created by Huy Than Duc on 27/12/2020.
//

import UIKit

class SearchResultController: UIViewController {
    @IBOutlet weak var labelSearch: UILabel!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var searchingView: UIStackView!
    @IBOutlet weak var bottomSlideView: NSLayoutConstraint!
    @IBOutlet weak var itemNotFound: UIStackView!
    @IBOutlet weak var labelTotalResult: UILabel!
    @IBOutlet weak var resultSearchCollection: UICollectionView!
    var keyWord : String = ""
    var listSearch : ResultSearch?
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSearch.text = keyWord
        APIRecipe.apiRecipe.searchByName = self
        APIRecipe.apiRecipe.searchRecipeByName(query: keyWord)
        setStyleSlide()
        setUpCollectionViewItemSize()
    }
    func setUpCollectionViewItemSize() {
        let customLayout = CustomLayout()
        customLayout.delegate = self
        resultSearchCollection.collectionViewLayout = customLayout
    }
    func setStyleSlide() {
        slideView.layer.cornerRadius = 30
        resultSearchCollection.register(ResultSearchCell.self, forCellWithReuseIdentifier: Instance.idResultSearchCell)
    }
    func finishSearch() {
        bottomSlideView.constant =  -30
        UIView.animate(withDuration: 1.5) { [weak self] in
            self!.searchingView.isHidden = true
            self?.view.layoutIfNeeded()
        }
    }
    @IBAction func goBackHomeView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchResultController : SearchByName {
    func getResultSearch(result: ResultSearch) {
        Instance.group.enter()
        Instance.semaphore.wait()
        DispatchQueue.main.async {
            self.labelTotalResult.text = "Found \(result.totalResults) results"
            self.itemNotFound.isHidden = result.totalResults != 0
            self.resultSearchCollection.isHidden = result.totalResults == 0
            self.listSearch = result
            self.resultSearchCollection.reloadData()
            self.finishSearch()
            
            Instance.group.leave()
            Instance.semaphore.signal()
        }
    }
}

extension SearchResultController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSearch?.results.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultSearchCollection.dequeueReusableCell(withReuseIdentifier: Instance.idResultSearchCell, for: indexPath) as! ResultSearchCell
        if let item = listSearch?.results[indexPath.row] {
            cell.ImageRecipe.getImageFromURL(imgURL: "https://spoonacular.com/recipeImages/\(item.image)")
            cell.labelMinute.text = "\(item.readyInMinutes) Minute"
            cell.labelTitle.text = item.title
        }
        return cell
    }
}

extension SearchResultController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeRecipeItem indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.5, height: view.frame.height/3)
    }
    
    
}
