//
//  FirstApplicationTests.swift
//  FirstApplicationTests
//
//  Created by Tran Vinh Quang on 10/26/15.
//  Copyright © 2015 Tran Vinh Quang. All rights reserved.
//

import XCTest
import UIKit
@testable import FirstApplication

class FirstApplicationTests: XCTestCase {
    
    func testMealInitialization() {
        let potentialItem = Meal(name: "Newest", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        let badRating = Meal(name: "Bad Rating", photo: nil, rating: -1)
        XCTAssertNil(badRating)
    }
    
}
