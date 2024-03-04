//
//  Flow.swift
//  QuizApp
//
//  Created by 이상헌 on 2/12/24.
//

import Foundation

class Flow<Delegate: QuizDelegate>{
  typealias Question = Delegate.Question
  typealias Answer = Delegate.Answer
  
  private let delegate: Delegate
  private let questions: [Question]
  private var answers: [Question: Answer] = [:]
  private var scoring: ([Question: Answer]) -> Int
  
  init(questions: [Question], delegate: Delegate, scoring: @escaping (([Question: Answer]) -> Int)) {
    self.questions = questions
    self.delegate = delegate
    self.scoring = scoring
  }
  
  func start() {
    if let firstQuestion = questions.first {
      delegate.handle(question: firstQuestion, answerCallback: nextCallBack(from: firstQuestion))
    } else {
      delegate.handle(result: result())
    }
  }
  
  private func nextCallBack(from question: Question) -> (Answer) -> Void {
    return { [weak self] answer in
      return self!.delegateNextHandling(question, answer)
    }
  }
  
  private func delegateNextHandling(_ question: Question, _ answer: Answer) {
    if let currentQuestionIndex = questions.index(of: question) {
      self.answers[question] = answer
      
      let nextQuestionIndex = currentQuestionIndex + 1
      if nextQuestionIndex < self.questions.count {
        let nextQuestion = self.questions[currentQuestionIndex + 1]
        delegate.handle(question: nextQuestion, answerCallback: self.nextCallBack(from: nextQuestion))
      } else {
        self.delegate.handle(result: result())
      }
    }
  }
  
  private func result() -> Result<Question, Answer> {
    return Result(answers, score: scoring(answers))
  }
}

// change router protocol without brake
// Steps (commit)
// create new Interface(Protocol)
// add deprecated message (Rotuer Protocol, startGame functionm, Game class)
// move deprecated components to a designated file (Rotuer Protocol, startGame functionm, Game class, QuizDelegateToRouterAdapter class)
// what should we do with the scoring function? (it's a leak detail)
// remove Hashable constraint from Question and make the result type generic
// remove testable import from QuizTest
// deprecate the Result type
// Breakdown protocols into Delegate/Datasource
