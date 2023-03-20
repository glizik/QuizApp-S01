//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Mac on 2023. 03. 20..
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    func test_start_withNoQuestions_() {
        let router = RouterSpy()
        let sut = Flow(router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
    }
}
