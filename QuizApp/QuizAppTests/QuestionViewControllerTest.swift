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
  
  func test_optionSelected_notifiesDelegate() {
    var receivedAnswer = ""
    let sut = makeSUT(options: ["A1"]) {
      receivedAnswer = $0
    }
    
    let indexPath = IndexPath(row: 0, section: 0)
    sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)

    XCTAssertEqual(receivedAnswer, "A1")
  }
  
  func makeSUT(
    question: String = "",
    options: [String] = [],
    selection: @escaping (String) -> Void = {_ in}) -> QuestionViewController
  {
    let sut = QuestionViewController(question: question, options: options, selection: selection)
    sut.loadViewIfNeeded()
    return sut
  }
  
}

private extension UITableView {
  func cell(at row: Int) -> UITableViewCell? {
    return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
  }
  
  func title(at row: Int) -> String? {
    cell(at: row)?.textLabel?.text
  }
}

extension XCTestCase {
  public func wait(timeout: TimeInterval) {
      let expectation = XCTestExpectation(description: "Waiting for \(timeout) seconds")
      XCTWaiter().wait(for: [expectation], timeout: timeout)
  }
}
