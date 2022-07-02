//
//  NavigationViewModel.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 30.06.22.
//

import Foundation
import UIKit

struct NavigationViewModel {
    
    private (set) var content: [NavigationItemModel] = [NavigationItemModel]()
    
    init(navigation: Navigation) {
        for (idx, itm) in navigation.navigationEntries.enumerated() {
            let model = NavigationItemModel(navigationItem: itm, id: idx)
            content.append(model)
        }
    }
    
    init(model: NavigationItemModel) {
        content = [model]
    }
    
    func sectionCount() -> Int {
        let filter = content.filter { itmModel in
            itmModel.type == .section
        }
        if filter.isEmpty {
            return 1
        }
        return filter.count
    }
    
    func sectionCount(idx: Int) -> Int {
        return content[idx].children?.count ?? 0
    }
    
    func section(idx: Int) -> NavigationItemModel? {
        if content[idx].type == .section {
            return content[idx]
        }
        return nil
    }
    
    func items(from indexPath: IndexPath) -> NavigationItemModel {
        let section = indexPath.section
        let row = indexPath.row
        let sectionModel = content[section]
        let children = sectionModel.children![row]
        return children
    }
}

struct NavigationItemModel: Equatable {
    static let idseparator = "-"
    
    static func == (lhs: NavigationItemModel, rhs: NavigationItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    private (set) var id: String
    var type: TypeEnum
    var label: String
    private (set) var children: [NavigationItemModel]?
    var url: String?
    
    fileprivate var navigationItem: NavigationItem!
    
    init(navigationItem: NavigationItem, id: Int, parentId: String? = nil) {
        self.type = navigationItem.type
        self.label = navigationItem.label
        self.url = navigationItem.url
        self.id = parentId != nil ? parentId! + NavigationItemModel.idseparator + String(id) : String(id)
        if let childs = navigationItem.children {
            children = [NavigationItemModel]()
            for (idx, itm) in childs.enumerated() {
                let model = NavigationItemModel(navigationItem: itm, id: idx, parentId: self.id)
                children?.append(model)
            }
        }
    }
}

internal extension Int {
    func stringId(size: Int = 4) -> String {
        var res = String(self)
        let count = 4 - res.count
        if count < 1 {
            return res
        }
        for _ in 1...count {
            res = "0" + res
        }
        return res
    }
}
