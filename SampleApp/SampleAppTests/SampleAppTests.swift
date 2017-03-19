//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by Dave Weston on 3/18/17.
//  Copyright © 2017 Binocracy. All rights reserved.
//

import XCTest
import SharedTestFramework

class SampleAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // Sample test adapted from NSHipster blog post: http://nshipster.com/xctestcase/
    func testAsynchronousURLConnection() {
        let url = URL(string: "https://www.google.com/")!
        let expectation = makeExpectation()

        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")

            if let HTTPResponse = response as? HTTPURLResponse,
                let responseURL = HTTPResponse.url,
                let mimeType = HTTPResponse.allHeaderFields["Content-Type"] as? String
            {
                XCTAssertEqual(responseURL.absoluteString, url.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertTrue(mimeType.hasPrefix("text/html"), "HTTP response content type should be text/html")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }

            expectation.fulfill()
        }

        task.resume()

        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
}
