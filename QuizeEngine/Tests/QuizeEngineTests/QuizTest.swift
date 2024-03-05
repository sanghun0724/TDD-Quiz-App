//
//  File.swift
//  
//
//  Created by 이상헌 on 3/4/24.
//

import XCTest
@testable import QuizeEngine

final class QuizTest: XCTestCase {
  
  private let delegate = DelegateSpy()
  private var quiz: Quiz!
  
  override func setUp() {
    super.setUp()
    
    quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers: ["Q1": "A1", "Q2": "A2"])
  }
  
  func test_startQuiz_answerOneOutOfTwoCorrectly_scoresZero() {
    delegate.answerCallback("wrong")
    delegate.answerCallback("wrong")
    
    XCTAssertEqual(delegate.handledResult!.score, 0)
  }

  func test_startQuiz_answerOneOutOfTwoCorrectly_scoresOne() {
    delegate.answerCallback("A1")
    delegate.answerCallback("wrong")
    
    XCTAssertEqual(delegate.handledResult!.score, 1)
  }
  
  func test_startQuiz_answerOneOutOfTwoCorrectly_scoresTwo() {
    delegate.answerCallback("A1")
    delegate.answerCallback("A2")
    
    XCTAssertEqual(delegate.handledResult!.score, 2)
  }
  
  private class DelegateSpy: QuizDelegate {
    var answerCallback: ((String) -> Void) = { _ in }
    var handledResult: Result<String, String>? = nil
    
    func answer(for question: String, completion: @escaping (String) -> Void) {
      self.answerCallback = completion
    }
    
    func handle(result: QuizeEngine.Result<String, String>) {
      handledResult = result
    }
  }

}

