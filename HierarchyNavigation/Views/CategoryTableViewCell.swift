//
//  CategoryTableViewCell.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 02.07.22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    var viewModel: NavigationItemModel! {
        didSet {
            var config = defaultContentConfiguration()
            config.text = viewModel.label
            config.textProperties.color = .blue
            contentConfiguration = config
            if viewModel.type == .node {
                accessoryType = .disclosureIndicator
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
