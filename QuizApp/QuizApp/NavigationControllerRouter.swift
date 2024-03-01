//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by 이상헌 on 3/1/24.
//

import UIKit
import QuizeEngine

enum Question<T: Hashable>: Hashable {
  case singleAnswer(T)
  case multipleAnswer(T)
  
  var hashValue: Int {
    switch self {
    case .singleAnswer(let value):
      return value.hashValue
    case .multipleAnswer(let value):
      return value.hashValue
    }
  }
}

protocol ViewControllerFactory {
  func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
  func resultsViewController(for result: Result<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
  private let navigationController: UINavigationController
  private let factory: ViewControllerFactory
  
  init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
    self.navigationController = navigationController
    self.factory = factory
  }
  
  func routeTo(question: Question<String>, answerCallback: @escaping (String) -> Void) {
    show(factory.questionViewController(for: question, answerCallback: answerCallback))
  }
  
  func routeTo(result: Result<Question<String>, String>) {
    show(factory.resultsViewController(for: result))
  }
  
  private func show(_ viewController: UIViewController) {
    navigationController.pushViewController(viewController, animated: true)
  }
}
