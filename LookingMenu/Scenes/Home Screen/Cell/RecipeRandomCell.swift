import UIKit

private enum ConstantRecipeRandomCelll: CGFloat {
    case radiusView = 30
    case constantAnchor = 4
    case multiplierWidthBackGroundView = 0.75
    case multiplierHeightImageRecipe = 0.55
    case multiplierTopImageRecipe = 0.15
}

final class RecipeRandomCell: UICollectionViewCell {
    let fontSizeTitle = 24
    let fontSizeMinute = 16
    lazy private var recipeCellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ConstantRecipeRandomCelll.radiusView.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var minuteLabel: UILabel = {
        let label = UILabel()
        label.setUpLabelCell(fontSize: fontSizeMinute)
        return label
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.setUpLabelCell(fontSize: fontSizeTitle)
        label.numberOfLines = 3
        return label
    }()
    
    lazy private var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = ConstantRecipeRandomCelll.radiusView.rawValue
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBackgroundView()
        addImageRecipe()
        addminuteLabelCook()
        addtitleLabelRecipe()
    }
    
    func configItemRecipeRandom(item: Recipe) {
        recipeImageView.getImageFromURL(imgURL: item.image)
        titleLabel.text = item.title
        minuteLabel.text = "\(item.readyInMinutes) Minute"
    }
    
    private func addBackgroundView() {
        addSubview(recipeCellBackgroundView)
        NSLayoutConstraint.activate([
            recipeCellBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            recipeCellBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            recipeCellBackgroundView.widthAnchor.constraint(
                equalToConstant:
                    frame.width - (ConstantRecipeRandomCelll.constantAnchor.rawValue * 4)),
            recipeCellBackgroundView.heightAnchor.constraint(
                equalToConstant:
                    frame.height * ConstantRecipeRandomCelll.multiplierWidthBackGroundView.rawValue)
        ])
        recipeCellBackgroundView.addShadowView(radius: ConstantRecipeRandomCelll.radiusView.rawValue)
    }
    
    private func addImageRecipe() {
        recipeCellBackgroundView.addSubview(recipeImageView)
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(
                equalTo: recipeCellBackgroundView.topAnchor,
                constant:
                    -(frame.width * ConstantRecipeRandomCelll.multiplierTopImageRecipe.rawValue)),
            recipeImageView.centerXAnchor.constraint(equalTo: recipeCellBackgroundView.centerXAnchor),
            recipeImageView.widthAnchor.constraint(
                equalToConstant:
                    frame.width - (ConstantRecipeRandomCelll.constantAnchor.rawValue * 10)),
            recipeImageView.heightAnchor.constraint(
                equalToConstant:
                    frame.height * ConstantRecipeRandomCelll.multiplierHeightImageRecipe.rawValue)
        ])
    }
    
    private func addtitleLabelRecipe() {
        recipeCellBackgroundView.addSubview(titleLabel)
        titleLabel.textColor = .blackDesign
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: recipeImageView.bottomAnchor,
                constant: ConstantRecipeRandomCelll.constantAnchor.rawValue),
            titleLabel.leadingAnchor.constraint(
                equalTo: recipeCellBackgroundView.leadingAnchor,
                constant: ConstantRecipeRandomCelll.constantAnchor.rawValue),
            titleLabel.trailingAnchor.constraint(
                equalTo: recipeCellBackgroundView.trailingAnchor,
                constant: -ConstantRecipeRandomCelll.constantAnchor.rawValue),
            titleLabel.bottomAnchor.constraint(
                equalTo: minuteLabel.topAnchor,
                constant: ConstantRecipeRandomCelll.constantAnchor.rawValue)
        ])
    }
    
    private func addminuteLabelCook() {
        recipeCellBackgroundView.addSubview(minuteLabel)
        minuteLabel.textColor = .redDesign
        NSLayoutConstraint.activate([
            minuteLabel.bottomAnchor.constraint(
                equalTo: recipeCellBackgroundView.bottomAnchor,
                constant: -(ConstantRecipeRandomCelll.constantAnchor.rawValue * 2)),
            minuteLabel.leadingAnchor.constraint(
                equalTo: recipeCellBackgroundView.leadingAnchor,
                constant: ConstantRecipeRandomCelll.constantAnchor.rawValue),
            minuteLabel.trailingAnchor.constraint(
                equalTo: recipeCellBackgroundView.trailingAnchor,
                constant: -ConstantRecipeRandomCelll.constantAnchor.rawValue)
        ])
    }
}
