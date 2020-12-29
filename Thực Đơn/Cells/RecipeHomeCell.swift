//
//  RecipeHomeCell.swift
//  Thực Đơn
//
//  Created by Huy Than Duc on 27/12/2020.
//

import UIKit

class RecipeHomeCell: UICollectionViewCell {
    lazy var parentView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var labelMinute : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var labelTitle : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 3
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var ImageView : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addParentView()
        addImageView()
        addMinuteCook()
        addTitleRecipe()
    }
    

    
    func addTitleRecipe() {
        addSubview(labelTitle)
        if let black = UIColor(named: "black") {
            labelTitle.textColor = black
        }
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: 5),
            labelTitle.leadingAnchor.constraint(equalTo: parentView.leadingAnchor,constant: 5),
            labelTitle.trailingAnchor.constraint(equalTo: parentView.trailingAnchor,constant: -5),
            labelTitle.bottomAnchor.constraint(equalTo: labelMinute.topAnchor, constant: 5)
        ])
    }
    func addMinuteCook() {
        addSubview(labelMinute)
        if let red = UIColor(named: "red") {
            labelMinute.textColor = red
        }
        NSLayoutConstraint.activate([
            labelMinute.bottomAnchor.constraint(equalTo: parentView.bottomAnchor,constant: -10),
            labelMinute.leadingAnchor.constraint(equalTo: parentView.leadingAnchor,constant: 5),
            labelMinute.trailingAnchor.constraint(equalTo: parentView.trailingAnchor,constant: -5)
        ])
    }
    func addImageView() {
        addSubview(ImageView)
        NSLayoutConstraint.activate([
            ImageView.topAnchor.constraint(equalTo: parentView.topAnchor,constant: -(frame.width*0.15)),
            ImageView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            ImageView.widthAnchor.constraint(equalToConstant: frame.width-40),
            ImageView.heightAnchor.constraint(equalToConstant: frame.height*0.55)
        ])
    }
    func addParentView() {
        addSubview(parentView)
        
        NSLayoutConstraint.activate([
            parentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            parentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            parentView.widthAnchor.constraint(equalToConstant: frame.width-20),
            parentView.heightAnchor.constraint(equalToConstant: frame.height*0.75)
        ])
        parentView.addShadowView(radius: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
