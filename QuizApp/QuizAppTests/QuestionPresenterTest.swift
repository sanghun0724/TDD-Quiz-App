//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/3/24.
//

import XCTest
import QuizeEngine
@testable import QuizApp

final class QuestionPresenterTest: XCTestCase {
  
  private let question1 = Question.singleAnswer("A1")
  private let question2 = Question.singleAnswer("A2")

  func test_title_forFirstQuestion_formatsTitleForIndex() {
    let sut = QuestionPresenter(questions: [question1, question2], question: question1)
    
    XCTAssertEqual(sut.title, "Question #1")
  }
  
  func test_title_forSecondQuestion_formatsTitleForIndex() {
    let sut = QuestionPresenter(questions: [question1, question2], question: question2)
    
    XCTAssertEqual(sut.title, "Question #2")
  }
  
  func test_title_forUnexistenQuestion_isEmpty() {
    let sut = QuestionPresenter(questions: [], question: Question.singleAnswer("A1"))
    
    XCTAssertEqual(sut.title, "")
  }
}
