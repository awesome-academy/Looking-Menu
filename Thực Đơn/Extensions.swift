//
//  extensions.swift
//  Thực Đơn
//
//  Created by Huy Than Duc on 27/12/2020.
//

import Foundation
import UIKit

extension UIImageView {
    func cornerCircle() {
        self.layer.cornerRadius = self.frame.height/2
    }
    func getImageFromURL(imgURL:String) {
        Instance.group.enter()
        Instance.semaphore.wait()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let url = URL(string: imgURL)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { [weak self] in
                self!.image = UIImage(data: data!)
            }
            Instance.semaphore.signal()
            Instance.group.leave()
        }
    }
}

extension UIView {
    func addShadowView(radius: CGFloat) {
        if let black = UIColor(named: "black") {
            self.layer.shadowColor = black.cgColor
            self.layer.shadowOpacity = 0.3
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = radius
        }
    }
}
