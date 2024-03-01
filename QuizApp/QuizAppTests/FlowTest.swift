//
//  FlowTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 2/11/24.
//

import XCTest
@testable import QuizApp

final class FlowTest: XCTestCase {
  
  let router = RouterSpy()
  
  func test_start_withNoQuestions_doesNotRouteToQuestion() {
    makeSUT(questions: []).start()
    
    XCTAssertTrue(router.routedQuestions.isEmpty)
  }
  
  func test_start_withOneQuestions_routesToCorrectQuestion() {
    makeSUT(questions: ["Q1"]).start()
    
    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }
  
  func test_start_withOneQuestions_routesToCorrectQuestion_2() {
    makeSUT(questions: ["Q2"]).start()
    
    XCTAssertEqual(router.routedQuestions, ["Q2"])
  }
  
  func test_start_withTwoQuestions_routesToFirstCorrectQuestion() {
    makeSUT(questions: ["Q1","Q2"]).start()
    
    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }
  
  func test_startTwice_withTwoQuestions_routesToFirstCorrectQuestion() {
    let sut = makeSUT(questions: ["Q1","Q2"])
    
    sut.start()
    sut.start()
    
    XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
  }
  
  func test_startAndAnswerFirstQuestionAndSecondQuestion_withThreeQuestions_routesToFirstCorrectQuestion() {
    let sut = makeSUT(questions: ["Q1","Q2","Q3"])
    sut.start()
    
    router.answerCallback("A1")
    router.answerCallback("A2")
    
    XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
  }
  
  func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
    let sut = makeSUT(questions: ["Q1"])
    sut.start()
    
    router.answerCallback("A1")
    
    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }
  
  func test_start_withNoQuestions_routesToResult() {
    makeSUT(questions: []).start()
    
    XCTAssertEqual(router.routedResult!.answers, [:])
  }
  
  func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteResult() {
    let sut = makeSUT(questions: ["Q1", "Q2"])
    sut.start()
    
    router.answerCallback("A1")
    
    XCTAssertNil(router.routedResult)
  }
  
  func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult() {
    let sut = makeSUT(questions: ["Q1", "Q2"])
    sut.start()
    
    router.answerCallback("A1")
    router.answerCallback("A2")
    
    XCTAssertEqual(router.routedResult!.answers, ["Q1": "A1", "Q2" : "A2"])
  }
  
  func test_startWithOneQuestion_doesNotRouteToResult() {
    makeSUT(questions: ["Q1"]).start()
    
    XCTAssertNil(router.routedResult)
  }
  
  func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
    let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 10 })
    sut.start()
    
    router.answerCallback("A1")
    router.answerCallback("A2")
    
    XCTAssertEqual(router.routedResult!.score, 10)
  }
  
  func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswers() {
    let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 20 })
    sut.start()
    
    router.answerCallback("A1")
    router.answerCallback("A2")
    
    XCTAssertEqual(router.routedResult!.score, 20)
  }
  
  // MARK: - Helper
  
  func makeSUT(
    questions: [String],
    scoring: @escaping ([String: String]) -> Int = { _ in 0 }
  ) -> Flow<String, String, RouterSpy> {
    return Flow(questions: questions, router: router, scoring: scoring)
  }
}

class RouterSpy: Router {
  var routedQuestions: [String] = []
  var answerCallback: ((String) -> Void) = { _ in }
  var routedResult: Result<String, String>? = nil
  
  func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
    routedQuestions.append(question)
    self.answerCallback = answerCallback
  }
  
  func routeTo(result: QuizApp.Result<String, String>) {
    routedResult = result
  }
}
