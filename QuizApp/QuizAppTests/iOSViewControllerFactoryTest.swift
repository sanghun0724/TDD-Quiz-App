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
  
  private let singleAnswerQuestion = Question.singleAnswer("Q1")
  private let multipleAnswerQuestion = Question.multipleAnswer("Q1")
  private let options = ["A1", "A2"]
  
  func test_questionViewController_singleAnswer_createControllerWithTitle() {
    let question = Question.singleAnswer("Q1")
    let presenter = QuestionPresenter(questions: [question], question: question)
    XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).title, presenter.title)
  }
  
  func test_questionViewController_singleAnswer_createControllerWithQuestion() {
    XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question, "Q1")
  }
  
  func test_questionViewController_singleAnswer_createControllerWithOptions() {
    XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).options, options)
  }
  
  func test_questionViewController_singleAnswer_createControllerWithSingleSelection() {
    let controller = makeQuestionController(question: singleAnswerQuestion)
    _ = controller.view
    
    XCTAssertFalse(controller.tableView.allowsMultipleSelection)
  }
  
  func test_questionViewController_multipleAnswer_createControllerWithTitle() {
    let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
    XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title, presenter.title)
  }
  
  func test_questionViewController_multipleAnswer_createControllerWithQuestion() {
    XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q1")
  }
  
  func test_questionViewController_multipleAnswer_createControllerWithOptions() {
    XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).options, options)
  }
  
  func test_questionViewController_multipleAnswer_createControllerWithSingleSelection() {
    XCTAssertTrue(makeQuestionController(question: multipleAnswerQuestion).allowsMultipleSelection)
  }
  
  // MARK: Helpers
  
  func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
    return iOSViewControllerFactory(for: [singleAnswerQuestion, multipleAnswerQuestion], options: options)
  }
  
  func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
    return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
  }
}
