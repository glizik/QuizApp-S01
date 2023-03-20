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
    // nameing: What we are testing, what should happen
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestionCount, 1)
    }

    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }

    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q2")
    }

    func test_start_withTwoQuestion_routesToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_startTwice_withTwoQuestion_routesToFirstQuestionTwice() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String?
        var routedQuestions: [String] = []
        
        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
            routedQuestions.append(question)
        }
    }
}
