//
//  FlowTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 2/11/24.
//

import XCTest
@testable import QuizeEngine

// Route -> Delegate 이름 변경 빡세다..
// 이런점을 보아 새로운 인터페이스 만들때 비스무리 하게 만들어서 네이밍 변경을 좀 덜하게 만들어도 좋을것 같다. (물론 네이밍의 우선순위는 커뮤니케이션이 일순위다..)
final class FlowTest: XCTestCase {
  
  private let delegate = DelegateSpy()
  
  func test_start_withNoQuestions_doesNotDelegateQuestionHandling() {
    makeSUT(questions: []).start()
    
    XCTAssertTrue(delegate.handledQuestions.isEmpty)
  }
  
  func test_start_withOneQuestions_delegatesCorrectQuestionHandling() {
    makeSUT(questions: ["Q1"]).start()
    
    XCTAssertEqual(delegate.handledQuestions, ["Q1"])
  }
  
  func test_start_withOneQuestions_delegatesAnotherCorrectQuestionHandling() {
    makeSUT(questions: ["Q2"]).start()
    
    XCTAssertEqual(delegate.handledQuestions, ["Q2"])
  }
  
  func test_start_withTwoQuestions_delegatesFirstCorrectQuestionHandling() {
    makeSUT(questions: ["Q1","Q2"]).start()
    
    XCTAssertEqual(delegate.handledQuestions, ["Q1"])
  }
  
  func test_startTwice_withTwoQuestions_delegatesToFirstCorrectQuestionHandling() {
    let sut = makeSUT(questions: ["Q1","Q2"])
    
    sut.start()
    sut.start()
    
    XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q1"])
  }
  
  func test_startAndAnswerFirstQuestionAndSecondQuestion_withThreeQuestions_delegatesFirstCorrectQuestionHandling() {
    let sut = makeSUT(questions: ["Q1","Q2","Q3"])
    sut.start()
    
    delegate.answerCompletion("A1")
    delegate.answerCompletion("A2")
    
    XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q2", "Q3"])
  }
  
  func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotdelegatesAnotherQuestionHandling() {
    let sut = makeSUT(questions: ["Q1"])
    sut.start()
    
    delegate.answerCompletion("A1")
    
    XCTAssertEqual(delegate.handledQuestions, ["Q1"])
  }
  
  func test_start_withNoQuestions_routesToResult() {
    makeSUT(questions: []).start()
    
    XCTAssertEqual(delegate.handledResult!.answers, [:])
  }
  
  func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotDelegatesResult() {
    let sut = makeSUT(questions: ["Q1", "Q2"])
    sut.start()
    
    delegate.answerCompletion("A1")
    
    XCTAssertNil(delegate.handledResult)
  }
  
  func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_delegatesResult() {
    let sut = makeSUT(questions: ["Q1", "Q2"])
    sut.start()
    
    delegate.answerCompletion("A1")
    delegate.answerCompletion("A2")
    
    XCTAssertEqual(delegate.handledResult!.answers, ["Q1": "A1", "Q2" : "A2"])
  }
  
  func test_startWithOneQuestion_doesNotDelegatesResult() {
    makeSUT(questions: ["Q1"]).start()
    
    XCTAssertNil(delegate.handledResult)
  }
  
  func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
    let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 10 })
    sut.start()
    
    delegate.answerCompletion("A1")
    delegate.answerCompletion("A2")
    
    XCTAssertEqual(delegate.handledResult!.score, 10)
  }
  
  func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswers() {
    let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 20 })
    sut.start()
    
    delegate.answerCompletion("A1")
    delegate.answerCompletion("A2")
    
    XCTAssertEqual(delegate.handledResult!.score, 20)
  }
  
  // MARK: - Helper
  
  private func makeSUT(
    questions: [String],
    scoring: @escaping ([String: String]) -> Int = { _ in 0 }
  ) -> Flow<DelegateSpy> {
    return Flow(questions: questions, delegate: delegate, scoring: scoring)
  }
  
  private class DelegateSpy: QuizDelegate {
    var handledQuestions: [String] = []
    var answerCompletion: ((String) -> Void) = { _ in }
    var handledResult: Result<String, String>? = nil
    
    // more safer to keep the old api, (migration 끝내는거 확정된 후에 delete)
    func answer(for question: String, completion: @escaping (String) -> Void) {
      handledQuestions.append(question)
      self.answerCompletion = completion
    }
    
    func handle(result: QuizeEngine.Result<String, String>) {
      handledResult = result
    }
  }

}
