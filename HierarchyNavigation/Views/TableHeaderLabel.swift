//
//  TableHeaderLabel.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 02.07.22.
//

import UIKit

class TableHeaderLabel: InsetLabel {
    
    required init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .blue
        font = UIFont.boldSystemFont(ofSize: 16)
    }
    
}
