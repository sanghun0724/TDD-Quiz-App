//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 2/25/24.
//

import UIKit
import XCTest
@testable import QuizApp

final class QuestionViewControllerTest: XCTestCase {
  
  func test_viewDidLoad_rendersQuestionHeaderText() {
    XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
  }
  
  func test_viewDidLoad_renderOptions() {
    XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
    XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
    XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
  }
  
  func test_viewDidLoad_renderOptionsText() {
    let sut = makeSUT(options: ["A1", "A2"])
    
    XCTAssertEqual(sut.tableView.title(at: 0), "A1")
    XCTAssertEqual(sut.tableView.title(at: 1), "A2")
  }
  
  func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
    var receivedAnswer = [String]()
    let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
    
    sut.tableView.select(row: 0)
    XCTAssertEqual(receivedAnswer, ["A1"])
    
    sut.tableView.select(row: 1)
    XCTAssertEqual(receivedAnswer, ["A2"])
  }
  
  func test_optionDeSelected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection() {
    var receivedAnswer = [String]()
    var callbackCount = 0
    let sut = makeSUT(options: ["A1", "A2"]) {  _ in callbackCount += 1 }
    
    sut.tableView.select(row: 0)
    XCTAssertEqual(callbackCount, 1)
    
    sut.tableView.deselect(row: 0)
    XCTAssertEqual(callbackCount, 1)
  }
  
  func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateWithLastSelection() {
    var receivedAnswer = [String]()
    let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
    sut.tableView.allowsMultipleSelection = true
    
    sut.tableView.select(row: 0)
    XCTAssertEqual(receivedAnswer, ["A1"])
    
    sut.tableView.select(row: 1)
    XCTAssertEqual(receivedAnswer, ["A1", "A2"])
  }
  
  func test_optionDeSelected_withMultipleSelectionEnabled_notifiesDelegate() {
    var receivedAnswer = [String]()
    let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
    sut.tableView.allowsMultipleSelection = true
    
    sut.tableView.select(row: 0)
    XCTAssertEqual(receivedAnswer, ["A1"])
    
    sut.tableView.deselect(row: 0)
    XCTAssertEqual(receivedAnswer, [])
  }
  
  func makeSUT(
    question: String = "",
    options: [String] = [],
    selection: @escaping ([String]) -> Void = {_ in}) -> QuestionViewController
  {
    let questionType = Question.singleAnswer(question)
    let factory = iOSViewControllerFactory(for: [], options: [questionType : options])
    let sut = factory.questionViewController(for: questionType, answerCallback: selection) as! QuestionViewController
    sut.loadViewIfNeeded()
    return sut
  }
  
}
