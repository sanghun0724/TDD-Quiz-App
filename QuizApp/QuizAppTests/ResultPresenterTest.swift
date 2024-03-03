//
//  ResultPresenterTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/2/24.
//

import XCTest
import QuizeEngine
@testable import QuizApp

final class ResultPresenterTest: XCTestCase {
  
  let singleAnswerQuestion = Question.singleAnswer("Q1")
  let multipleAnswerQuestion = Question.multipleAnswer("Q2")
  
  func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
    let answers = [Question.singleAnswer("Q1"): ["A1"], Question.multipleAnswer("Q2"): ["A2", "A3"]]
    let result = Result(answers, score: 1)
    
    let sut = ResultsPresenter(result: result, questions: [singleAnswerQuestion], options: [:], correctAnswers: [:])
    
    XCTAssertEqual(sut.summary, "You got 1/2 correct")
  }
  
  func test_presentableAnswers_withoutQuestion_isEmpty() {
    let answers = Dictionary<Question<String>, [String]>()
    let result = Result(answers, score: 0)
    
    let sut = ResultsPresenter(result: result, questions: [], options: [:], correctAnswers: [:])
    
    XCTAssertTrue(sut.presentableAnswers.isEmpty)
  }
  
  func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
    let answers = [singleAnswerQuestion: ["A1"]]
    let correctAnswers = [singleAnswerQuestion: ["A2"]]
    let orderedOptions = [singleAnswerQuestion: ["A1", "A2"]]
    let result = Result(answers, score: 0)
    
    let sut = ResultsPresenter(result: result, questions: [singleAnswerQuestion], options: orderedOptions, correctAnswers: correctAnswers)
    
    XCTAssertEqual(sut.presentableAnswers.count, 1)
    XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
    XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
    XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
  }
  
  func test_presentableAnswers_withWrongMutipleAnswer_mapsAnswer() {
    let answers = [multipleAnswerQuestion: ["A1", "A4"]]
    let options = [multipleAnswerQuestion: ["A1", "A4"]]
    let correctAnswers = [multipleAnswerQuestion: ["A2", "A3"]]
    let result = Result(answers, score: 0)
    
    let sut = ResultsPresenter(result: result, questions: [multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    
    XCTAssertEqual(sut.presentableAnswers.count, 1)
    XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
    XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
    XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
  }
  
  func test_presentableAnswers_withRightSingleAnswer_mapsAnswer() {
    let answers = [Question.singleAnswer("Q1"): ["A1"]]
    let orderedOptions = [singleAnswerQuestion: ["A1", "A2"]]
    let correctAnswers = [Question.singleAnswer("Q1"): ["A1"]]
    let result = Result(answers, score: 0)
    
    let sut = ResultsPresenter(result: result, questions: [Question.singleAnswer("Q1")], options: orderedOptions, correctAnswers: correctAnswers)
    
    XCTAssertEqual(sut.presentableAnswers.count, 1)
    XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
    XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
    XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
  }
  
  func test_presentableAnswers_withRightMultipleAnswer_mapsAnswer() {
    let answers = [multipleAnswerQuestion: ["A1", "A4"]]
    let orderedOptions = [multipleAnswerQuestion: ["A1", "A4"]]
    let correctAnswers = [multipleAnswerQuestion: ["A1", "A4"]]
    let result = Result(answers, score: 0)
    
    let sut = ResultsPresenter(result: result, questions: [multipleAnswerQuestion], options: orderedOptions, correctAnswers: correctAnswers)
    
    XCTAssertEqual(sut.presentableAnswers.count, 1)
    XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
    XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
    XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
  }
  
  func test_presentableAnswers_withTwoQuestions_mapsOrderAnswer() {
    let answers = [multipleAnswerQuestion: ["A1", "A4"], singleAnswerQuestion: ["A2"]]
    let orderedOptions = [multipleAnswerQuestion: ["A1", "A4"], singleAnswerQuestion: ["A2"]]
    let correctAnswers = [multipleAnswerQuestion: ["A1", "A4"], singleAnswerQuestion: ["A2"]]
    let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
    let result = Result(answers, score: 0)
    
    let sut = ResultsPresenter(result: result, questions: orderedQuestions, options: orderedOptions, correctAnswers: correctAnswers)
    
    XCTAssertEqual(sut.presentableAnswers.count, 2)
    XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
    XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
    XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
  
    XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
    XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1, A4")
    XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)
  }

}
