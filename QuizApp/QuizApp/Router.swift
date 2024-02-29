//
//  Router.swift
//  QuizApp
//
//  Created by 이상헌 on 2/29/24.
//

import Foundation

protocol Router {
  associatedtype Question: Hashable
  associatedtype Answer
  
  func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
  func routeTo(result: Result<Question, Answer>)
}
