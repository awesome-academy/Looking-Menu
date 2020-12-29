//
//  ResultSearchCell.swift
//  Thực Đơn
//
//  Created by Huy Than Duc on 28/12/2020.
//

import UIKit

class ResultSearchCell: UICollectionViewCell {
    lazy var ImageRecipe : UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var labelMinute : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = UIColor(named: "red")
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var labelTitle : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = UIColor(named: "black")
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 3
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        addContainerView()
    }
    func addLabelMinute() {
        containerView.addSubview(labelMinute)
        
        NSLayoutConstraint.activate([
            labelMinute.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            labelMinute.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            labelMinute.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    func addLabelTitle() {
        containerView.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
            labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            labelTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            labelTitle.topAnchor.constraint(equalTo: ImageRecipe.bottomAnchor, constant: 5),
            labelTitle.bottomAnchor.constraint(equalTo: labelMinute.bottomAnchor, constant: -5)
        ])
    }
    func addImageView() {
        containerView.addSubview(ImageRecipe)
        NSLayoutConstraint.activate([
            ImageRecipe.centerXAnchor.constraint(equalTo: centerXAnchor),
            ImageRecipe.widthAnchor.constraint(equalToConstant: frame.width-40)
            ,ImageRecipe.heightAnchor.constraint(equalToConstant: frame.width-40),
            ImageRecipe.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        ImageRecipe.layer.cornerRadius = (frame.width-40)/2
    }
    func addContainerView() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
            ,containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ])
        containerView.addShadowView(radius: 20)
        addImageView()
        addLabelMinute()
        addLabelTitle()
    }
}
