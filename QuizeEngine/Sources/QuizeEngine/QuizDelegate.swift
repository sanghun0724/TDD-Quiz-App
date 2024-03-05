//
//  File.swift
//  
//
//  Created by 이상헌 on 3/4/24.
//

import Foundation

// naming flowDelegate 탈락 -> flow는 게임엔진의 internal 구현임. (🌟 leak implementation)
public protocol QuizDelegate {
  associatedtype Question: Hashable
  associatedtype Answer
  
  func answer(for question: Question, completion: @escaping (Answer) -> Void)
  
  @available(*, deprecated, message: "use  renamed: didCompleteQui(with answers:)")
  func handle(result: Result<Question, Answer>)
  
//  func answer(for question: Question, completion: @escaping (Answer) -> Void) // asks answer
//  func didCompleteQuiz(with answers: [(question: Question, answer: Answer)]) // tells answer
}

#warning("delete this at som point!")
public extension QuizDelegate {
  func didCompleteQuiz(with answers: [(question: Question, answer: Answer)]) {}
}
