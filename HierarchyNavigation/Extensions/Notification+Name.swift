//
//  Notification+Name.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 03.02.21.
//

import Foundation

public extension Notification {
    static let requestDidFinish: Name = Notification.Name("requestDidFinish")
    static let requestDidError: Name = Notification.Name("requestDidError")
    static let navigationLoadDidFinish: Name = Notification.Name("navigationLoadDidFinish")
    static let toyLinkSelected: Name = Notification.Name("toyLinkSelected")
    static let categoryStack: Name = Notification.Name("categoryStack")
}
