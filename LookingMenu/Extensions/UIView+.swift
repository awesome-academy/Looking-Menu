import Foundation
import UIKit

extension UIView {
    func cornerCircle() {
        layer.cornerRadius = frame.height / 2
    }
    
    func addShadowView(radius: CGFloat) {
        layer.shadowColor = UIColor.blackDesign.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
    }
}
