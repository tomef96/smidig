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
            subcategory: "",
            time: ""
        )
        testDB.append(event)
        let event2 = Event(
            owner: "",
            place: "",
            description: "spille hockey",
            date: "",
            spots: "",
            title: "Hockey",
            eventId: "",
            category: "",
            subcategory: "",
            time: ""
        )
        testDB.append(event2)
    }

    override func tearDown() {
        
    }

    func testShouldFindEvent() {
        let result = searcher.search(keyword: "fotball", events: testDB)
        XCTAssert(result?.count == 1)
    }
    
    func testShouldNotFindAnyEvents() {
        let result = searcher.search(keyword: "dsboinsdf", events: testDB)
        XCTAssert(result?.count == 0)
    }
    
    func testShouldNotSearchForSpace() {
        let result = searcher.search(keyword: " ", events: testDB)
        XCTAssert(result == nil)
    }
    
    func testShouldSearchForPartial() {
        let result = searcher.search(keyword: "spill", events: testDB)
        XCTAssert(result?.count == 2)
    }

}
