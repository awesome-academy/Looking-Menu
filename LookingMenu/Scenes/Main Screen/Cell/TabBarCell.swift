import UIKit

private enum ConstantTabBarCell: CGFloat {
    case sizeTabBarLabel = 13
    case spaceTabBarBackground = 20
    case sizeTabBarIcon = 35
    case spaceTabBarIcon = 5
}

final class TabBarCell: UICollectionViewCell {
    private var constraintCenterHorizontalIcon: NSLayoutConstraint?
    private var constraintLeadingIcon: NSLayoutConstraint?
    private lazy var tabBarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .grayDesign
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tabBarLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayDesign
        label.font = UIFont.boldSystemFont(ofSize: ConstantTabBarCell.sizeTabBarLabel.rawValue)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tabBarViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewBackgroundToTabbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(item: TabBar) {
        if let image = UIImage(named: item.icon) {
            tabBarIcon.image = image.withRenderingMode(.alwaysTemplate)
            tabBarLabel.text = item.label
        }
    }
    
    override var isSelected: Bool {
        didSet {
            let red = UIColor.redDesign
            let gray = UIColor.grayDesign
            tabBarViewBackground.backgroundColor = isSelected ?
                red.withAlphaComponent(0.4) : .white
            if let horizontalIcon = constraintCenterHorizontalIcon,
               let leftIcon = constraintLeadingIcon {
                horizontalIcon.isActive = !isSelected
                leftIcon.isActive = isSelected
            }
            tabBarIcon.tintColor = isSelected ? red : gray
            tabBarLabel.textColor = isSelected ? red : gray
            tabBarLabel.isHidden = !isSelected
            animationIconItemTabBarSelected()
        }
    }
    
    private func animationIconItemTabBarSelected() {
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    private func addViewBackgroundToTabbar() {
        addSubview(tabBarViewBackground)
        tabBarViewBackground.contentHuggingPriority(for: .horizontal)
        NSLayoutConstraint.activate([
            tabBarViewBackground.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ConstantTabBarCell.spaceTabBarBackground.rawValue),
            tabBarViewBackground.widthAnchor.constraint(
                equalToConstant: frame.width),
            tabBarViewBackground.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -ConstantTabBarCell.spaceTabBarBackground.rawValue)
        ])
        tabBarViewBackground.layer.cornerRadius =
            (frame.height - (ConstantTabBarCell.spaceTabBarBackground.rawValue * 2)) / 2
        addIconTotabBarViewBackground()
        addLabelTotabBarViewBackground()
    }
    
    private func addLabelTotabBarViewBackground() {
        tabBarViewBackground.addSubview(tabBarLabel)
        NSLayoutConstraint.activate([
            tabBarLabel.leadingAnchor.constraint(
                equalTo: tabBarIcon.trailingAnchor,
                constant: ConstantTabBarCell.spaceTabBarIcon.rawValue),
            tabBarLabel.trailingAnchor.constraint(
                equalTo: tabBarViewBackground.trailingAnchor),
            tabBarLabel.centerYAnchor.constraint(
                equalTo: tabBarIcon.centerYAnchor)
        ])
        tabBarLabel.isHidden = true
    }
    
    private func addIconTotabBarViewBackground() {
        tabBarViewBackground.addSubview(tabBarIcon)
        constraintLeadingIcon = tabBarIcon.leadingAnchor.constraint(
            equalTo: tabBarViewBackground.leadingAnchor,
            constant: ConstantTabBarCell.spaceTabBarIcon.rawValue)
        constraintCenterHorizontalIcon = tabBarIcon.centerXAnchor.constraint(
            equalTo: centerXAnchor)
        if let horizontalIcon = constraintCenterHorizontalIcon,
           let leftIcon = constraintLeadingIcon {
            horizontalIcon.isActive = true
            leftIcon.isActive = false
        }
        NSLayoutConstraint.activate([
            tabBarIcon.widthAnchor.constraint(
                equalToConstant: ConstantTabBarCell.sizeTabBarIcon.rawValue),
            tabBarIcon.heightAnchor.constraint(
                equalToConstant: ConstantTabBarCell.sizeTabBarIcon.rawValue),
            tabBarIcon.centerYAnchor.constraint(
                equalTo: tabBarViewBackground.centerYAnchor)
        ])
    }
}
