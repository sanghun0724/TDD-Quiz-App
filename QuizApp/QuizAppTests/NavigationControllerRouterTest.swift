//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//

import UIKit
import XCTest
import QuizeEngine
@testable import QuizApp

final class NavigationControllerRouterTest: XCTestCase {
  
  let singleAnswerQuestion = Question.singleAnswer("Q1")
  let multipleAnswerQuestion = Question.multipleAnswer("Q2")
  
  let navigationController = NonAnimatedNavigationController()
  let factory = ViewControllerFactoryStub()
  lazy var sut = { return NavigationControllerRouter(navigationController, factory: factory) }()
  
  func test_routeToSecondQuestion_presentQuestionController() {
    let viewController = UIViewController()
    let secondViewcontroller = UIViewController()
    factory.stub(question: singleAnswerQuestion, with: viewController)
    factory.stub(question: multipleAnswerQuestion, with: secondViewcontroller)
    
    sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
    sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
    
    
    XCTAssertEqual(navigationController.viewControllers.count, 2)
    XCTAssertEqual(navigationController.viewControllers.first, viewController)
    XCTAssertEqual(navigationController.viewControllers.last, secondViewcontroller)
  }
  
  func test_routeToQuestion_presentQuestionControllerWithRightCallback() {
    factory.stub(question: singleAnswerQuestion, with: UIViewController())
    
    var callbackWasFired = false
    sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })
    factory.answerCallback[singleAnswerQuestion]!(["anything"])
    
    XCTAssertTrue(callbackWasFired)
  }
  
  func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
    var callbackWasFired = false
    sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })
    
    factory.answerCallback[singleAnswerQuestion]!(["anything"])
    
    XCTAssertTrue(callbackWasFired)
  }
  
  func test_routeToQuestion_singleAnswer_doesNotConfigureViewControllerWithSubmitButton() {
    let viewController = UIViewController()
    factory.stub(question: singleAnswerQuestion, with: viewController)

    sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
    
    XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
  }
  
  func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressesToNextQuestion() {
    var callbackWasFired = false
    sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })
    
    factory.answerCallback[multipleAnswerQuestion]!(["anything"])
    
    XCTAssertFalse(callbackWasFired)
  }
  
  func test_routeToQuestion_multipleAnswer_configureViewControllerWithSubmitButton() {
    let viewController = UIViewController()
    factory.stub(question: multipleAnswerQuestion, with: viewController)

    sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
    
    XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
  }
  
  func test_routeToQuestion_multipleAnswerSubmitButton_isDisabledWhenZeroAnswersSelected() {
    let viewController = UIViewController()
    factory.stub(question: multipleAnswerQuestion, with: viewController)

    sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
    XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    
    factory.answerCallback[multipleAnswerQuestion]!(["A1"])
    XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    
    factory.answerCallback[multipleAnswerQuestion]!([])
    XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
  }
  
  func test_routeToQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {
    let viewController = UIViewController()
    factory.stub(question: multipleAnswerQuestion, with: viewController)

    var callbackWasFired = false
    sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })

    factory.answerCallback[multipleAnswerQuestion]!(["A1"])
    let button = viewController.navigationItem.rightBarButtonItem!
    
    button.target!.performSelector(onMainThread: button.action!, with: nil, waitUntilDone: true)
    
    XCTAssertTrue(callbackWasFired)
  }
  
  func test_routeToQuestion_showsResultController() {
    let viewController = UIViewController()
    let result = Result([singleAnswerQuestion: ["A1"]], score: 10)
    
    let secondViewController = UIViewController()
    let secondResult = Result([multipleAnswerQuestion: ["A2"]], score: 20)

    factory.stub(result: result, with: viewController)
    factory.stub(result: secondResult, with: secondViewController)
    
    sut.routeTo(result: result)
    sut.routeTo(result: secondResult)
    
    XCTAssertEqual(navigationController.viewControllers.count, 2)
    XCTAssertEqual(navigationController.viewControllers.first, viewController)
    XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
  }
  
  // MARK: Helper
  
  /// naver animated for test
  class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      super.pushViewController(viewController, animated: false)
    }
  }
  
  class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedQuestions = [Question<String>: UIViewController]()
    private var stubbedResults = Dictionary<Result<Question<String>, [String]>, UIViewController>()
    var answerCallback = [Question<String>: ([String]) -> Void]()
    
    func stub(question: Question<String>, with viewController: UIViewController) {
      stubbedQuestions[question] = viewController
    }
    
    func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
      stubbedResults[result] = viewController
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
      self.answerCallback[question] = answerCallback
      return stubbedQuestions[question] ?? UIViewController()
    }
    
    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
      stubbedResults[result] ?? UIViewController()
    }
  }
}

private extension UIBarButtonItem {
  func simulateTap() {
    target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
  }
}
