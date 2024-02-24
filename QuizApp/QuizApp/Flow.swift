//
//  Flow.swift
//  QuizApp
//
//  Created by 이상헌 on 2/12/24.
//

import Foundation

protocol Router {
  typealias AnswerCallBack = (String) -> Void
  func routeTo(question: String, answerCallback: @escaping AnswerCallBack)
  func routeTo(result: [String: String]) // what's meaning?
}

class Flow {
  private let router: Router
  private let questions: [String]
  
  init(questions: [String], router: Router) {
    self.questions = questions
    self.router = router
  }
  
  func start() {
    if let firstQuestion = questions.first {
      router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
    } else {
      
    }
  }
  
  private func routeNext(from question: String) -> Router.AnswerCallBack {
    return { [weak self] _ in
      guard let self else { return }
      let currentQuestionIndex = questions.index(of: question)!
      guard currentQuestionIndex + 1 < questions.count else { return }
      let nextQuestion = self.questions[currentQuestionIndex + 1]
      router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
    }
  }
}
