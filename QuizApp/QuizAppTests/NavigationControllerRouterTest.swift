//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//

import XCTest
@testable import QuizApp

final class NavigationControllerRouterTest: XCTestCase {

  func test_routeToQuestion_presentQuestionController() {
    let navigationController = UINavigationController()
    let sut = NavigationControllerRouter(navigationController)
    
    sut.routeTo(question: "Q1", answerCallback: { _ in })
    
    XCTAssertEqual(navigationController.viewControllers.count, 1)
  }
  
  func test_routeToQuestionTwice_presentQuestionController() {
    let navigationController = UINavigationController()
    let sut = NavigationControllerRouter(navigationController)
    
    sut.routeTo(question: "Q1", answerCallback: { _ in })
    sut.routeTo(question: "Q2", answerCallback: { _ in })
    
    XCTAssertEqual(navigationController.viewControllers.count, 2)
  }

}
