//
//  searchTests.swift
//  smidigTests
//
//  Created by Tom Fevang on 14/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import XCTest
@testable import smidig

class searchTests: XCTestCase {
    
    let searcher = Searcher()
    
    var testDB = [Event]()

    override func setUp() {
        let event = Event(
            owner: "",
            place: "",
            description: "spille fotball",
            date: "",
            spots: "",
            title: "Fotball",
            eventId: "",
            category: "",
            time: "",
            participants: []
        )
        testDB.append(event)
        let event2 = Event(
            owner: "",
            place: "",
            description: "møtes bak ishallen, spiller et par timer",
            date: "",
            spots: "",
            title: "spis grus",
            eventId: "",
            category: "Sport",
            time: "",
            participants: []
        )
        testDB.append(event2)
    }

    override func tearDown() {
        
    }

    func testShouldFindEvent() {
        let result = searcher.search(for: "fotball", in: testDB)
        XCTAssert(result?.count == 1)
    }
    
    func testShouldNotFindAnyEvents() {
        let result = searcher.search(for: "dsboinsdf", in: testDB)
        XCTAssert(result?.count == 0)
    }
    
    func testShouldNotReturnOnSpace() {
        let result = searcher.search(for: " ", in: testDB)
        XCTAssert(result == nil)
    }
    
    func testShouldReturnOnPartial() {
        let result = searcher.search(for: "spill", in: testDB)
        XCTAssert(result?.count == 2)
    }
    
    func testShouldReturnOnCategory() {
        let result = searcher.search(for: "sport", in: testDB)
        XCTAssert(result?.count == 1)
    }

}
