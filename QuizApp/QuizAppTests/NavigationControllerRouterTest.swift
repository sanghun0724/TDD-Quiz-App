//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//

import Foundation
import XCTest

class NavigationControllerRouterTest: XCTest {
  
  func test_routeToQuestion_presentQuestionController() {
    let navigationController = UINavigationController()
    let sut = NavigationControllerRouter(navigationController)
    
    sut.routeTo(question: "Q1", answerCallback: { _ in })
    
    XCTAssertEqual(navigationController.viewControllers.count, 1)
  }
}
