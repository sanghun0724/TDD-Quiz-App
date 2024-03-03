//
//  Router.swift
//  QuizApp
//
//  Created by 이상헌 on 2/29/24.
//

import Foundation

// naming flowDelegate 탈락 -> flow는 게임엔진의 internal 구현임. (🌟 leak implementation)
public protocol QuizDelegate {
  associatedtype Question: Hashable
  associatedtype Answer
  
  func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
  func handle(result: Result<Question, Answer>)
}

@available(*, deprecated)
public protocol Router {
  associatedtype Question: Hashable
  associatedtype Answer
  
  func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
  func routeTo(result: Result<Question, Answer>)
}

// change router protocol without brake
// Steps (commit)
// add deprecated message router protocol
// create new protocol
// remove Hashable constraint from Question and make the result type generic
//
