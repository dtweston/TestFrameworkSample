//
//  XCTestExtensions.swift
//  SharedTestFramework
//
//  Created by Dave Weston on 3/18/17.
//  Copyright © 2017 Binocracy. All rights reserved.
//

import Foundation
import XCTest

public extension XCTestCase {
    func makeExpectation() -> XCTestExpectation {
        return expectation(description: "")
    }
}
