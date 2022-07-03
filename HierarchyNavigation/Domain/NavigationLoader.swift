//
//  Navigation.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 29.06.22.
//

import Foundation

final class NavigationLoader: JsonDecodeDelegate {
    private var decoder: JSONDecode!
    
    init() {
        decoder = JSONDecode()
        decoder.delegate = self
    }
    
    func decoded<T>(data: T?) where T : Decodable {
        if let navigation = data as? Navigation {
            NotificationCenter.default.post(name: Notification.navigationLoadDidFinish, object: nil, userInfo: [Constant.UserInfoKey.navigation: navigation])
        } else {
            // TO DO: put the error in a global Error object
            print("Error fetch data")
        }
    }
    
    func startDecode() {
        decoder.decode(type: Navigation.self)
    }
    
    func excecute() {
        let request = NavigationRequest(completionHandler: requestDidFinished(request:))
        request.send()
    }
    
    private func requestDidFinished(request: NavigationRequest) {
        decoder.data = request.data
    }
}
