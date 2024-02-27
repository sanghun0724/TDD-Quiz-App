//
//  Flow.swift
//  QuizApp
//
//  Created by 이상헌 on 2/12/24.
//

import Foundation

protocol Router {
  associatedtype Question: Hashable
  associatedtype Answer

  func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
  func routeTo(result: [Question: Answer])
}

class Flow<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
  private let router: R
  private let questions: [Question]
  private var result: [Question: Answer] = [:]
  
  init(questions: [Question], router: R) {
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
  
  private func nextCallBack(from question: Question) -> (Answer) -> Void {
    return { [weak self] in self?.routeNext(question, $0) }
  }
  
  private func routeNext(_ question: Question, _ answer: Answer) {
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
