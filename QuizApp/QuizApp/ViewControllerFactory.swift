//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by 이상헌 on 3/1/24.
//

import UIKit
import QuizeEngine

protocol ViewControllerFactory {
  func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
  func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}
