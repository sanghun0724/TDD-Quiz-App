//
//  FlowTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 2/11/24.
//

import XCTest
@testable import QuizApp

final class FlowTest: XCTestCase {
  
  func test_start_withNoQuestions_doesNotRouteToQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: [], router: router)
    
    sut.start()
    
    XCTAssertEqual(router.routedQuestionCount, 0)
  }
    
  func test_start_withOneQuestions_routesToQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q1"], router: router)
    
    sut.start()
    
    XCTAssertEqual(router.routedQuestionCount, 1)
  }
  
  func test_start_withOneQuestions_routesToCorrectQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q1"], router: router)
    
    sut.start()
    
    XCTAssertEqual(router.routedQuestion, "Q1")
  }
  
  func test_start_withOneQuestions_routesToCorrectQuestion_2() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q2"], router: router)
    
    sut.start()
    
    XCTAssertEqual(router.routedQuestion, "Q2")
  }
  
  func test_start_withOneQuestions_routesToFirstCorrectQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q1","Q2"], router: router)
    
    sut.start()
    
    XCTAssertEqual(router.routedQuestion, "Q1")
  }
  
  class RouterSpy: Router {
    var routedQuestionCount: Int = 0
    var routedQuestion: String? = nil
    
    func routeTo(question: String) {
     routedQuestionCount += 1
      routedQuestion = question
    }
  }
}
