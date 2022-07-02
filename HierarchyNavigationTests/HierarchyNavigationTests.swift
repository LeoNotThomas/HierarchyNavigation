//
//  HierarchyNavigationTests.swift
//  HierarchyNavigationTests
//
//  Created by Thomas Leonhardt on 29.06.22.
//

import XCTest
@testable import HierarchyNavigation

class HierarchyNavigationTests: XCTestCase {
    
    private var navigation: Navigation? {
        guard let path = Bundle(for: type(of: self)).path(forResource: "smallNavigation", ofType: "json") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            return try! decoder.decode(Navigation.self, from: data)
        } catch {
            XCTAssertTrue(false, "Can't read data")
        }
        return nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNavigationReading() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "navigation", ofType: "json") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(Navigation.self, from: data) else {
                XCTAssertTrue(false, "Can't decode data")
                return
            }
            XCTAssertFalse(decodedData.navigationEntries.isEmpty, "No entries found")
        } catch {
            XCTAssertTrue(false, "Can't read data")
        }
    }
    
    func testNavigationViewModelSectionCount() {
        if let navigation = navigation {
            let viewModel = NavigationViewModel(navigation: navigation)
            let count = viewModel.sectionCount()
            XCTAssertTrue(count == 2, "Wrong sectionCount")
        }
    }
    
    func testNavigationViewModelSectionFromIndexPath() {
        if let navigation = navigation {
            let viewModel = NavigationViewModel(navigation: navigation)
            let indexPath = IndexPath(row: 0, section: 0)
            let model = viewModel.items(from: indexPath)
            XCTAssertTrue(model.id == "0-0", "Wrong id found")
        }
    }
    
    func testtNavigationViewModelInitWithModel() {
        if let navigation = navigation {
            let viewModel = NavigationViewModel(navigation: navigation)
            let indexPath = IndexPath(row: 0, section: 0)
            let model = viewModel.items(from: indexPath)
            let newModel = NavigationViewModel(model: model)
            return
        }
    }
    
    func testStringIdOne() {
        let expected = "0001"
        let res = 1.stringId()
        XCTAssertTrue(res == expected, "Result: \(res), Expected: \(expected)")
    }
    
    func testStringId1000() {
        let expected = "1000"
        let res = 1000.stringId()
        XCTAssertTrue(res == expected, "Result: \(res), Expected: \(expected)")
    }

}
