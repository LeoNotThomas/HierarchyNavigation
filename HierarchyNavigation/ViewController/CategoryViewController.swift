//
//  CategoryViewController.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 01.07.22.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate (set) var viewModel: NavigationViewModel!
    
    private var selectedItem: NavigationItemModel?
    
    class func instatiateFromStoryBoard(viewModel: NavigationViewModel, selectedItem: NavigationItemModel? = nil) -> CategoryViewController {
        let storyboard = UIStoryboard(name: "CategoryViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! CategoryViewController
        vc.viewModel = viewModel
        vc.selectedItem = selectedItem
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.closeItem(target: self, action: #selector(close))
    }
    
    @objc
    private func close() {
        self.dismiss(animated: true)
        NotificationCenter.default.post(name: Notification.categoryStack, object: nil, userInfo: [Constant.UserInfoKey.navigationStack: [] as Any])
    }

}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let itm = viewModel.section(idx: section), itm.type == .section {
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let itm = viewModel.section(idx: section), itm.type == .section {
            let label = TableHeaderLabel()
            label.text = itm.label
            return label
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionCount(idx: section)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        let model = viewModel.items(from: indexPath)
        cell.viewModel = model
        return cell
    }


}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell, let model = cell.viewModel {
            switch model.type {
            case .externalLink:
                guard let link = model.url, let url = URL(string: link) else {
                    return
                }
                UIApplication.shared.open(url)
            case .link:
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Notification.toyLinkSelected, object: nil, userInfo: [Constant.UserInfoKey.toyLink: model.url as Any])
                NotificationCenter.default.post(name: Notification.categoryStack, object: nil, userInfo: [Constant.UserInfoKey.navigationStack: navigationController?.viewControllers as Any])
            case .node:
                let viewModel = NavigationViewModel(model: model)
                let categoryViewController = CategoryViewController.instatiateFromStoryBoard(viewModel: viewModel)
                categoryViewController.title = model.label
                self.navigationController?.pushViewController(categoryViewController, animated: true)
            default:
                break
            }
        }
    }

}
