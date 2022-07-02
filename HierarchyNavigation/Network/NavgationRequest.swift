//
//  NavgationRequest.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 29.06.22.
//

import Foundation

class NavigationRequest: APIRequest {
    typealias ReplyHandler = (NavigationRequest) -> Void
    
    var completionHandler: ReplyHandler?
    
    init(completionHandler: @escaping ReplyHandler) {
        super.init(url: "https://codechallenge.mobilelab.io/v1/mytoys/navigation")
        self.completionHandler = completionHandler;
    }
    
    override var additionalHeadersFields: [String: String] {
        return ["x-api-key": "N8Nx0OwOvo1iuN2ZkFHZlyVKBVgoIcy4tUHMppO5"]
    }
    
    override func deliverResult() {
        completionHandler?(self)
    }
}
