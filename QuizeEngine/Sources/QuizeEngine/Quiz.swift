//
//  File.swift
//  
//
//  Created by 이상헌 on 3/4/24.
//

import Foundation

final class Quiz {
  private let flow: Any
  
  init(flow: Any) {
    self.flow = flow
  }
  
  public static func start<Delegate: QuizDelegate>(
    questions: [Delegate.Question],
    delegate: Delegate,
    correctAnswers: [Delegate.Question: Delegate.Answer]
  ) -> Quiz where Delegate.Answer: Equatable {
    let flow = Flow(
      questions: questions,
      delegate: delegate,
      scoring: { scoring($0, correctAnswers: correctAnswers) }
    )
    flow.start()
    return Quiz(flow: flow)
  }
}

func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question : Answer], correctAnswers: [Question: Answer]) -> Int {
  return answers.reduce(0) { (score, tuple) in
    return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
  }
}

