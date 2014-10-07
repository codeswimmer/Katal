//
//  KatalTests.swift
//  KatalDesktop
//
//  Created by Keith Ermel on 10/5/14.
//  Copyright (c) 2014 Keith Ermel. All rights reserved.
//

import Cocoa
import XCTest


class KatalTests: XCTestCase {

    let inputToParse = "[≫]}{('HELLO')}{[Console]}{[String.upperCase]}{[Console]}{[≪]"
    let katal = Katal()

    override func setUp() {super.setUp()}
    override func tearDown() {super.tearDown()}

    func testParseTransform() {
        let result = katal.perform(inputToParse)
        println("result: \(result)")
        
        XCTAssertNotNil(result, "result should not be nil")
    }

    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    */
}
