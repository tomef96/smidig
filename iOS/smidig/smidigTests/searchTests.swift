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

    func testShouldReadSearchResultCorrectly() {
        let result = searcher.search(keyword: "fotball", events: testDB)
        XCTAssert(result.count == 1)
    }
    
    func testShouldReturnEmptyArray() {
        let result = searcher.search(keyword: "dsboinsdf", events: testDB)
        XCTAssert(result.count == 0)
    }

    /*func checkForSearchParam(events: [Event], searchParam: String) -> Bool {
        var result = false
        let lc = searchParam.lowercased()
        for event in events {
            if event.title.lowercased().contains(lc) {
                result = true
            } else if event.description.lowercased().contains(lc) {
                result = true
            } else if event.subcategory.lowercased().contains(lc) {
                result = true
            }
            else {
                return result
            }
        }
        return result
    }*/
}
