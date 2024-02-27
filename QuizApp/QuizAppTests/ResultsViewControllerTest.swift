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
        let sut = ResultsViewController(summary: "a summary")
        
        _ = sut.viewIfLoaded
        
        XCTAssertEqual(sut.headerLabel.text, "a summary")
        
    }

}
