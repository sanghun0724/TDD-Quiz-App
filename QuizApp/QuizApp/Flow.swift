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
  
  private var result: [String: String] = [:]
  
  init(questions: [String], router: Router) {
    self.questions = questions
    self.router = router
  }
  
  func start() {
    if let firstQuestion = questions.first {
      router.routeTo(question: firstQuestion, answerCallback: nextCallBack(from: firstQuestion))
    } else {
      router.routeTo(result: [:])
    }
  }
  
  private func nextCallBack(from question: String) -> Router.AnswerCallBack {
    return { [weak self] in self?.routeNext(question, $0) }
  }
  
  private func routeNext(_ question: String, _ answer: String) {
    if let currentQuestionIndex = questions.index(of: question) {
      self.result[question] = answer
      
      let nextQuestionIndex = currentQuestionIndex + 1
      if nextQuestionIndex < self.questions.count {
        let nextQuestion = self.questions[currentQuestionIndex + 1]
        router.routeTo(question: nextQuestion, answerCallback: self.nextCallBack(from: nextQuestion))
      } else {
        self.router.routeTo(result: self.result)
      }
    }
  }
}
