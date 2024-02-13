//
//  Flow.swift
//  QuizApp
//
//  Created by 이상헌 on 2/12/24.
//

import Foundation

protocol Router {
  func routeTo(question: String)
}

class Flow {
  let router: Router
  let questions: [String]
  
  init(questions: [String], router: Router) {
    self.questions = questions
    self.router = router
  }
  
  func start() {
    if !questions.isEmpty {
      router.routeTo(question: questions.first!)
    }
  }
}
