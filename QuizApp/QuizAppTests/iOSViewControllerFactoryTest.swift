//
//  iOSViewControllerFactory.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//

import XCTest
@testable import QuizApp

final class iOSViewControllerFactoryTest: XCTestCase {
  
  func test_questionViewController_createController() {
    let question = Question.singleAnswer("Q1")
    let options = ["A1", "A2"]
    let sut = iOSViewControllerFactory(options: [question: options])
    
    let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as? QuestionViewController
    
    XCTAssertEqual(controller?.question, "Q1")
  }
  
  func test_questionViewController_createControllerWithOptions() {
    let question = Question.singleAnswer("Q1")
    let options = ["A1", "A2"]
    let sut = iOSViewControllerFactory(options: [question: options])
    
    let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as? QuestionViewController
    
    XCTAssertEqual(controller?.options, options)
  }
}
