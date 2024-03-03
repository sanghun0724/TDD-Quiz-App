//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//

import XCTest
@testable import QuizeEngine

final class QuestionTest: XCTestCase {

  func test_hashValue_signleAnswer_returnTypeHash() {
    let type = "a string"
    
    let sut = Question.singleAnswer(type)
    
    XCTAssertEqual(sut.hashValue, type.hashValue)
  }
  
  func test_hashValue_multipleAnswer_returnTypeHash() {
    let type = "a string"
    
    let sut = Question.multipleAnswer(type)
    
    XCTAssertEqual(sut.hashValue, type.hashValue)
  }
  
  func test_equal_singleAnswer_isEqual() {
    XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
  }
  
  func test_notEqual_singleAnswer_isNotEqual() {
    XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
  }
  
  func test_equal_multipleAnswer_isEqual() {
    XCTAssertEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("a string"))
  }
  
  func test_notEqual_multipleAnswer_isNotEqual() {
    XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
  }

}
