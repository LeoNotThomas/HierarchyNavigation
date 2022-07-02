//
//  UIBarButtonItem+ImageButton.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 30.06.22.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func menuItem(target: Any, action: Selector) -> UIBarButtonItem {
        let button: UIButton = UIButton.imageButton(imageNamed: "menu", target: target, action: action)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    static func closeItem(target: Any, action: Selector) -> UIBarButtonItem {
        let button: UIButton = UIButton.imageButton(imageNamed: "cross", target: target, action: action)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
}
