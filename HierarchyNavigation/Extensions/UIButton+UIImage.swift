//
//  UIButton+UIImage.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 30.06.22.
//

import Foundation
import UIKit

extension UIButton {
    static func imageButton(imageNamed: String, target: Any, action: Selector) -> UIButton {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: imageNamed), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        button.addTarget(target, action: action, for: .touchDown)
        return button
    }
}
