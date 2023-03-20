//
//  Flow.swift
//  QuizEngine
//
//  Created by Mac on 2023. 03. 20..
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

extension Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void = { _ in }) {
        print("Answer Callback not implemented")
        routeTo(question: question, answerCallback: answerCallback)
    }
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let strongSelf = self else { return }
                let firstQuestionIndex = strongSelf.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex + 1]
                strongSelf.router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
