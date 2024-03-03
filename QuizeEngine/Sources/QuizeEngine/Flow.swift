//
//  Flow.swift
//  QuizApp
//
//  Created by 이상헌 on 2/12/24.
//

import Foundation

class Flow<R: QuizDelegate>{
  typealias Question = R.Question
  typealias Answer = R.Answer
  
  private let router: R
  private let questions: [Question]
  private var answers: [Question: Answer] = [:]
  private var scoring: ([Question: Answer]) -> Int
  
  init(questions: [Question], router: R, scoring: @escaping (([Question: Answer]) -> Int)) {
    self.questions = questions
    self.router = router
    self.scoring = scoring
  }
  
  func start() {
    if let firstQuestion = questions.first {
      router.handle(question: firstQuestion, answerCallback: nextCallBack(from: firstQuestion))
    } else {
      router.handle(result: result())
    }
  }
  
  private func nextCallBack(from question: Question) -> (Answer) -> Void {
    return { [weak self] answer in
      return self!.routeNext(question, answer)
    }
  }
  
  private func routeNext(_ question: Question, _ answer: Answer) {
    if let currentQuestionIndex = questions.index(of: question) {
      self.answers[question] = answer
      
      let nextQuestionIndex = currentQuestionIndex + 1
      if nextQuestionIndex < self.questions.count {
        let nextQuestion = self.questions[currentQuestionIndex + 1]
        router.handle(question: nextQuestion, answerCallback: self.nextCallBack(from: nextQuestion))
      } else {
        self.router.handle(result: result())
      }
    }
  }
  
  private func result() -> Result<Question, Answer> {
    return Result(answers, score: scoring(answers))
  }
}
