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
    guard let options = self.options[question] else {
      fatalError("Coudn't find options for question")
    }
    return questionViewController(for: question, options: options, answerCallback: answerCallback)
  }
  
  private func questionViewController(for question: Question<String>, options: [String], answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
    switch question {
    case .singleAnswer(let value):
      return QuestionViewController(question: value, options: options, selection: answerCallback)
    case .multipleAnswer(let value):
      let controller = QuestionViewController(question: value, options: options, selection: answerCallback)
      _ = controller.view
      controller.tableView.allowsMultipleSelection = true
      return controller
    }
  }
  
  func resultsViewController(for result: QuizeEngine.Result<Question<String>, [String]>) -> UIViewController {
    return UIViewController()
  }
}
