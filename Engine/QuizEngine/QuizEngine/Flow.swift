//
//  Flow.swift
//  QuizEngine
//
//  Created by Mac on 2023. 03. 20..
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

extension Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void = { _ in }) {
        print("Answer Callback not implemented")
        routeTo(question: question, answerCallback: answerCallback)
    }
}

class Flow {
    private let router: Router
    private let questions: [String]
    
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallback(from question: String) -> Router.AnswerCallback {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                router.routeTo(question: questions[nextQuestionIndex],
                               answerCallback: nextCallback(from: questions[nextQuestionIndex]))
            } else {
                router.routeTo(result: result)
            }
        }
    }
}
