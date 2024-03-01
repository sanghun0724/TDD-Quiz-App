//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by 이상헌 on 3/1/24.
//

import UIKit
import QuizeEngine

class NavigationControllerRouter: Router {
  private let navigationController: UINavigationController
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
    navigationController.pushViewController(UIViewController(), animated: false)
  }
  
  func routeTo(result: Result<String, String>) {
    
  }
}
