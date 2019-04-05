//
//  rss_parser_testTests.swift
//  rss-parser-testTests
//
//  Created by Vladimir Vetrov on 04/04/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import XCTest
import FeedKit

@testable import rss_parser_test

class rss_parser_testTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let feedURL = URL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")!
            
            let parser = FeedParser(URL: feedURL)
            
            parser.parse()
        }
    }

}
