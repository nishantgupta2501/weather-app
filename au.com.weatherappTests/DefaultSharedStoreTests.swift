//
//  DefaultSharedStoreTests.swift
//  au.com.weatherappTests
//
//  Created by Nishant Gupta on 21/7/21.
//

import XCTest
@testable import au_com_weatherapp

class DefaultSharedStoreTests: XCTestCase {

    func testExample() {
        XCTAssertTrue(DefaultSharedStore().isValid(forKey: StorageKey.mockStoreKey))
    }

}

extension StorageKey {
    static let mockStoreKey = StorageKey(rawValue: "Mock", accessControl: .SharedDefault)
}
