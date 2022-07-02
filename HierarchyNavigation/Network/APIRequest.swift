//
//  APIRequest.swift
//  HierarchyNavigation
//
//  Created by Thomas Leonhardt on 29.06.22.
//

import Foundation

class APIRequest {
    
    private (set) var url: URL!
    fileprivate (set) var error: Error?
    fileprivate (set) var data: Data?
    
    var additionalHeadersFields: [String: String] {
        return [:]
    }
    
    init(url: String) {
        self.url = URL(string: url)
    }
    
    private func reset() {
        self.data = nil
        self.error = nil
    }
    
    func deliverResult() {
        preconditionFailure("must be overridden in concrete subclasses")
    }
    
    final func makeTask() -> URLSessionTask {
        let request = NSMutableURLRequest(url: url)
        request.allHTTPHeaderFields = additionalHeadersFields
        let urlSession = URLSession(configuration: .default)
        return urlSession.dataTask(with: request as URLRequest) { data, response, error in
            guard let _ = data else {
                NotificationCenter.default.post(name: Notification.requestDidFinish, object: self)
                self.deliverResult()
                return
            }
            self.data = data
            self.error = error
            
            self.deliverResult()
            NotificationCenter.default.post(name: Notification.requestDidFinish, object: self)
        }
    }
    
    func send() {
        reset()
        let task = makeTask()
        task.resume()
    }
}
