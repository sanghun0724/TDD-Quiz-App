//
//  iOSViewControllerFactory.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//
import UIKit
import XCTest
@testable import QuizApp

final class iOSViewControllerFactoryTest: XCTestCase {
  
  private let options = ["A1", "A2"]
  
  func test_questionViewController_singleAnswer_createControllerWithQuestion() {
    XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).question, "Q1")
  }
  
  func test_questionViewController_singleAnswer_createControllerWithOptions() {
    XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).options, options)
  }
  
  func test_questionViewController_singleAnswer_createControllerWithSingleSelection() {
    let controller = makeQuestionController(question: Question.singleAnswer("Q1"))
    _ = controller.view
    
    XCTAssertFalse(controller.tableView.allowsMultipleSelection)
  }
  
  func test_questionViewController_multipleAnswer_createControllerWithQuestion() {
    XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).question, "Q1")
  }
  
  func test_questionViewController_multipleAnswer_createControllerWithOptions() {
    XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).options, options)
  }
  
  func test_questionViewController_multipleAnswer_createControllerWithSingleSelection() {
    let controller = makeQuestionController(question: Question.multipleAnswer("Q1"))
    _ = controller.view
    
    XCTAssertTrue(controller.tableView.allowsMultipleSelection)
  }
  
  // MARK: Helpers
  
  func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
    return iOSViewControllerFactory(options: options)
  }
  
  func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
    return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
  }
}
