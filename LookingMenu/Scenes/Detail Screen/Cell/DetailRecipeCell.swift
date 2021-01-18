import UIKit

private enum ConstantRecipeCell {
    static let radiusView: CGFloat = 20
    static let fontSizeTitle = 24
    static let constantAnchor: CGFloat = 8
    static let constantDetailBG: CGFloat = 4
}

final class DetailRecipeCell: UITableViewCell {
    lazy private var detailRecipeBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var detailRecipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var detailRecipeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .blackDesign
        label.setUpLabelCell(fontSize: ConstantRecipeCell.fontSizeTitle)
        return label
    }()
    
    override func layoutSubviews() {
        addDetailBackground()
    }
    
    func configDetailRecipeCell(item: Detail, typeDetailCell: Bool) {
        detailRecipeImageView.getImageFromURL(
            imgURL: String(format: UrlAPIRecipe.urlImageRecipeDetail,
                           typeDetailCell ? "ingredients" : "equipment",
                           item.image
            ))
        detailRecipeTitleLabel.text = item.name
    }
    
    private func addDetailTitle() {
        detailRecipeBackground.addSubview(detailRecipeTitleLabel)
        NSLayoutConstraint.activate([
            detailRecipeTitleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ConstantRecipeCell.constantAnchor),
            detailRecipeTitleLabel.leadingAnchor.constraint(
                equalTo: detailRecipeImageView.trailingAnchor,
                constant: ConstantRecipeCell.constantAnchor),
            detailRecipeTitleLabel.centerYAnchor.constraint(equalTo: detailRecipeImageView.centerYAnchor)
        ])
    }
    
    private func addDetailImage() {
        detailRecipeBackground.addSubview(detailRecipeImageView)
        NSLayoutConstraint.activate([
            detailRecipeImageView.leadingAnchor.constraint(
                equalTo:detailRecipeBackground.leadingAnchor,
                constant: ConstantRecipeCell.constantAnchor),
            detailRecipeImageView.widthAnchor.constraint(equalToConstant: frame.width * 0.4),
            detailRecipeImageView.topAnchor.constraint(
                equalTo: detailRecipeBackground.topAnchor,
                constant: ConstantRecipeCell.constantDetailBG),
            detailRecipeImageView.bottomAnchor.constraint(
                equalTo: detailRecipeBackground.bottomAnchor,
                constant: -ConstantRecipeCell.constantDetailBG)
        ])
        detailRecipeImageView.layer.cornerRadius = detailRecipeImageView.frame.height / 2
    }
    
    private func addDetailBackground() {
        addSubview(detailRecipeBackground)
        NSLayoutConstraint.activate([
            detailRecipeBackground.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ConstantRecipeCell.constantDetailBG),
            detailRecipeBackground.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ConstantRecipeCell.constantDetailBG),
            detailRecipeBackground.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ConstantRecipeCell.constantDetailBG),
            detailRecipeBackground.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -ConstantRecipeCell.constantDetailBG)
        ])
        detailRecipeBackground.layer.cornerRadius = detailRecipeBackground.frame.height / 2
        addDetailImage()
        addDetailTitle()
    }
}
