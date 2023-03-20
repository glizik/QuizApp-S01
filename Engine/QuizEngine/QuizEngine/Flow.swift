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
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))
        }
    }
    
    func routeNext(_ question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            let currentQuestionIndex = strongSelf.questions.firstIndex(of: question)!
            let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
            strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(nextQuestion))
        }
    }
}
