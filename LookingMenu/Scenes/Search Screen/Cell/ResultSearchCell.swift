import UIKit

private enum ConstantResultSearchCell {
    static let radiusView: CGFloat = 20
    static let constantAnchor: CGFloat = 4
    static let paddingRecipeImage: CGFloat = 10
    static let topView: CGFloat = 50
}

final class ResultSearchCell: UICollectionViewCell {
    let fontSizeLabelMinute = 20
    let fontSizeLabelTitle = 16
    
    private lazy var containerResultCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var minuteCookingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .redDesign
        label.setUpLabelCell(fontSize: fontSizeLabelMinute)
        return label
    }()
    
    private lazy var titleRecipeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .blackDesign
        label.setUpLabelCell(fontSize: fontSizeLabelTitle)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addContainerView()
    }
    
    func configSearchCell(image: String, title: String, minute: String) {
        recipeImage.getImageFromURL(imgURL: image)
        minuteCookingLabel.text = minute
        titleRecipeLabel.text = title
    }
    
    
    private func addLabelMinute() {
        containerResultCell.addSubview(minuteCookingLabel)
        NSLayoutConstraint.activate([
            minuteCookingLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ConstantResultSearchCell.constantAnchor),
            minuteCookingLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ConstantResultSearchCell.constantAnchor),
            minuteCookingLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -(ConstantResultSearchCell.constantAnchor * 2))
        ])
    }
    
    private func addLabelTitle() {
        containerResultCell.addSubview(titleRecipeLabel)
        NSLayoutConstraint.activate([
            titleRecipeLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ConstantResultSearchCell.constantAnchor),
            titleRecipeLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ConstantResultSearchCell.constantAnchor),
            titleRecipeLabel.topAnchor.constraint(
                equalTo: recipeImage.bottomAnchor,
                constant: ConstantResultSearchCell.constantAnchor),
            titleRecipeLabel.bottomAnchor.constraint(
                equalTo: minuteCookingLabel.bottomAnchor,
                constant: -ConstantResultSearchCell.constantAnchor)
        ])
    }
    
    private func addImageView() {
        containerResultCell.addSubview(recipeImage)
        NSLayoutConstraint.activate([
            recipeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            recipeImage.widthAnchor.constraint(equalToConstant:
                                                frame.width - ConstantResultSearchCell.paddingRecipeImage),
            recipeImage.heightAnchor.constraint(equalToConstant:
                                                    frame.width - ConstantResultSearchCell.paddingRecipeImage),
            recipeImage.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ConstantResultSearchCell.constantAnchor * 2)
        ])
        recipeImage.layer.cornerRadius =
            (frame.width - ConstantResultSearchCell.paddingRecipeImage) / 2
    }
    
    private func addContainerView() {
        addSubview(containerResultCell)
        NSLayoutConstraint.activate([
            containerResultCell.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ConstantResultSearchCell.constantAnchor),
            containerResultCell.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ConstantResultSearchCell.constantAnchor),
            containerResultCell.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -ConstantResultSearchCell.constantAnchor),
            containerResultCell.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ConstantResultSearchCell.topView)
        ])
        containerResultCell.addShadowView(
            radius: ConstantResultSearchCell.radiusView)
        addImageView()
        addLabelMinute()
        addLabelTitle()
    }
}
