//
//  Flow.swift
//  QuizEngine
//
//  Created by Mac on 2023. 03. 20..
//

import Foundation

protocol Router {}

class Flow {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        
    }
}
