//
//  ResultsViewControllerTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 2/27/24.
//

import XCTest
@testable import QuizApp

final class ResultsViewControllerTest: XCTestCase {
  
  func test_viewDidLoad_renderSummary() {
    XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
  }
  
  func test_viewDidLoad_withoutAnswers_rendersAnswer() {
    XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
    let sut = makeSUT(answers: [makeDummyAnswer()])
    XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
  }
  
  func test_viewDidLoad_withCorrectAnswer_rendersCorrectAnswerCell() {
    let sut = makeSUT(answers: [makeDummyAnswer()])
    
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
    
    XCTAssertNotNil(cell)
  }
  
  private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
    let sut = ResultsViewController(summary: summary, answers: answers)
    _ = sut.view
    return sut
  }
  
  private func makeDummyAnswer() -> PresentableAnswer {
    return PresentableAnswer(isCorrect: false)
  }
  
  
}
