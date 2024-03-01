//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by 이상헌 on 3/1/24.
//

import XCTest
@testable import QuizApp

final class NavigationControllerRouterTest: XCTestCase {
  
  let navigationController = NonAnimatedNavigationController()
  let factory = ViewControllerFactoryStub()
  lazy var sut = { return NavigationControllerRouter(navigationController, factory: factory) }()
  
  func test_routeToSecondQuestion_presentQuestionController() {
    let viewController = UIViewController()
    let secondViewcontroller = UIViewController()
    factory.stub(question: "Q1", with: viewController)
    factory.stub(question: "Q2", with: secondViewcontroller)
    
    sut.routeTo(question: "Q1", answerCallback: { _ in })
    sut.routeTo(question: "Q2", answerCallback: { _ in })
    
    
    XCTAssertEqual(navigationController.viewControllers.count, 2)
    XCTAssertEqual(navigationController.viewControllers.first, viewController)
    XCTAssertEqual(navigationController.viewControllers.last, secondViewcontroller)
  }
  
  func test_routeToQuestion_presentQuestionControllerWithRightCallback() {
    factory.stub(question: "Q1", with: UIViewController())
    
    var callbackWasFired = false
    sut.routeTo(question: "Q1", answerCallback: { _ in callbackWasFired = true })
    factory.answerCallback["Q1"]!("anything")
    
    XCTAssertTrue(callbackWasFired)
  }
  
  /// naver animated for test
  class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      super.pushViewController(viewController, animated: false)
    }
  }
  
  class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedQuestions = [String: UIViewController]()
    var answerCallback = [String: (String) -> Void]()
    
    func stub(question: String, with viewController: UIViewController) {
      stubbedQuestions[question] = viewController
    }
    
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
      self.answerCallback[question] = answerCallback
      return stubbedQuestions[question] ?? UIViewController()
    }
  }

}
