//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by 이상헌 on 3/1/24.
//

import UIKit
import QuizeEngine

class iOSViewControllerFactory: ViewControllerFactory {
  
  private let options: Dictionary<Question<String>, [String]>
  
  init(options: Dictionary<Question<String>, [String]>) {
    self.options = options
  }
  
  func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
    switch question {
    case .singleAnswer(let value):
      return QuestionViewController(question: value, options: options[question]!, selection: answerCallback)
    default:
      return UIViewController()
    }
  }
  
  func resultsViewController(for result: QuizeEngine.Result<Question<String>, [String]>) -> UIViewController {
    return UIViewController()
  }
  
  
}
