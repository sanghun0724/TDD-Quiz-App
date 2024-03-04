//
//  Result.swift
//  QuizApp
//
//  Created by 이상헌 on 2/29/24.
//

import Foundation

@available(*, deprecated)
public struct Result<Question: Hashable, Answer>: Hashable {
  public var answers: [Question: Answer]
  public var score: Int
  
  public init(_ answers: [Question: Answer], score: Int) {
    self.answers = answers
    self.score = score
  }
  
  public var hashValue: Int {
    return 1
  }
  
  public static func == (lhs: QuizeEngine.Result<Question, Answer>, rhs: QuizeEngine.Result<Question, Answer>) -> Bool {
    return lhs.score == rhs.score
  }
}
