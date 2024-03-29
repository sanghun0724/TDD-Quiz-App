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
    let sut = makeSUT(answers: [makeAnswer()])
    XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
  }
  
  func test_viewDidLoad_withCorrectAnswer_configureCell() {
    let answer = makeAnswer(question: "Q1", answer: "A1")
    let sut = makeSUT(answers: [answer])
    
    let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
    
    XCTAssertNotNil(cell)
    XCTAssertEqual(cell?.questionLabel.text, "Q1")
    XCTAssertEqual(cell?.answerLabel.text, "A1")
  }
  
  func test_viewDidLoad_withWrongAnswer_configureCell() {
    let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")
    let sut = makeSUT(answers: [answer])
    
    let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
    
    XCTAssertNotNil(cell)
    XCTAssertEqual(cell?.questionLabel.text, "Q1")
    XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
  }
  
  private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
    let sut = ResultsViewController(summary: summary, answers: answers)
    _ = sut.view
    return sut
  }
  
  private func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
    return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
  }
  
}
