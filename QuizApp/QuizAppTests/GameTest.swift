//
//  GameTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//

import XCTest
@testable import QuizApp

final class GameTest: XCTestCase {
  
  let router = RouterSpy()
  var game: Game<String, String, RouterSpy>!
  
  override func setUp() {
    super.setUp()
    
    game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
  }
  
  func test_startGame_answerOneOutOfTwoCorrectly_scoresZero() {
    router.answerCallback("wrong")
    router.answerCallback("wrong")
    
    XCTAssertEqual(router.routedResult!.score, 0)
  }

  func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
    router.answerCallback("A1")
    router.answerCallback("wrong")
    
    XCTAssertEqual(router.routedResult!.score, 1)
  }
  
  func test_startGame_answerOneOutOfTwoCorrectly_scoresTwo() {
    router.answerCallback("A1")
    router.answerCallback("A2")
    
    XCTAssertEqual(router.routedResult!.score, 2)
  }
  

}
