//
//  iOSViewControllerFactory.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//
import UIKit
import XCTest
import QuizeEngine
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
  
  func test_resultsViewController_createsControllerWithSummary() {
    let results = makeResults()
    XCTAssertEqual(results.controller.summary, results.presenter.summary)
  }
  
  func test_resultsViewController_createsControllerWithPresentableAnswers() {
    let results = makeResults()
    XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
  }
  
  // MARK: Helpers
  
  func makeSUT(options: Dictionary<Question<String>, [String]> = [:], correctAnswers: Dictionary<Question<String>, [String]> = [:]) -> iOSViewControllerFactory {
    return iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
  }
  
  func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
    return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
  }
  
  func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
    let userAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
    let correctAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
    let questions = [singleAnswerQuestion, multipleAnswerQuestion]
    let result = Result(userAnswers, score: 2)
    let orderedOptions = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
    
    let presenter = ResultsPresenter(result: result, questions: questions, options: orderedOptions, correctAnswers: correctAnswers)
    let sut = makeSUT(correctAnswers: correctAnswers)
    let controller = sut.resultsViewController(for: result) as! ResultsViewController
    return (controller, presenter)
  }
}
