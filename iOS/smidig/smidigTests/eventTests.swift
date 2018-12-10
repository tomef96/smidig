//
//  eventTests.swift
//  smidigTests
//
//  Created by Tom Fevang on 10/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//
import XCTest
@testable import smidig

class eventTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var event: Event
        event.author = "Jan-Kristian"
        event.title = "Æ e ensom"
        event.description = "Hjælp"
        event.places = 1
        XCTAssert(event.author == "Jan-Kristian")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
