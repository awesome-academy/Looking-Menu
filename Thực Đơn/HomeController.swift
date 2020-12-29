//
//  HomeController.swift
//  Thực Đơn
//
//  Created by Huy Than Duc on 25/12/2020.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var HomeRecipe: UICollectionView!
    var list : Recipes?
    override func viewDidLoad() {
        super.viewDidLoad()
        configHomeView()
        APIRecipe.apiRecipe.delegate = self
        APIRecipe.apiRecipe.getRandomRecipe(number: 5)
    }
    func configHomeView() {
        icon.cornerCircle()
        HomeRecipe.register(RecipeHomeCell.self, forCellWithReuseIdentifier: Instance.idRecipeHomeCell)
        HomeRecipe.collectionViewLayout.invalidateLayout()
    }
}


extension HomeController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.recipes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: HomeRecipe.frame.width/1.5, height: HomeRecipe.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeRecipe.dequeueReusableCell(withReuseIdentifier: Instance.idRecipeHomeCell, for: indexPath) as! RecipeHomeCell
        if let item = list?.recipes[indexPath.row] {
            cell.ImageView.getImageFromURL(imgURL: item.image)
            cell.labelTitle.text = item.title
            cell.labelMinute.text = "\(item.readyInMinutes) M"
        }
        return cell
    }
    
}

extension HomeController : DataDelegate {
    func listRecipeRandom(recipes: Recipes) {
        DispatchQueue.main.async {
            self.list = recipes
            self.HomeRecipe.reloadData()
        }
    }
}

extension HomeController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchResultController
        searchVC.keyWord = searchBar.text ?? ""
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}
