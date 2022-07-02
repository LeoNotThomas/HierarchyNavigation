//
//  Navigation.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 29.06.22.
//

import Foundation

// MARK: - Navigation
struct Navigation: Codable {
    let navigationEntries: [NavigationItem]
}

// MARK: - NavigationEntry
struct NavigationItem: Codable {
    let type: TypeEnum
    let label: String
    let children: [NavigationItem]?
    let url: String?
}

enum TypeEnum: String, Codable {
    case externalLink = "external-link"
    case link = "link"
    case node = "node"
    case section = "section"
}
