//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 2/25/24.
//

import Foundation
import XCTest

final class QuestionViewControllerTest: XCTestCase {
  
  func test_viewDidLoad_rendersQuestionHeaderText() {
    let sut = QuestionViewController(question: "Q1")
    
    _ = sut.view
    
    XCTAssertEqual(sut.headerLabel.text, "Q1")
  }
    

}
