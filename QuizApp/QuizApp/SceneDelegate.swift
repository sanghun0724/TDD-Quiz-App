//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by 이상헌 on 2/11/24.
//

import UIKit
import QuizeEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var game: Game<Question<String>, [String], NavigationControllerRouter>?
  
  private lazy var navigationController = UINavigationController()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let question1 = Question.singleAnswer("Where are H from?")
    let question2 = Question.multipleAnswer("Where are J from?")
    let questions = [question1, question2]
    
    let option1 = "Canadian"
    let option2 = "Anmerican"
    let option3 = "Greek"
    let options1 = [option1, option2, option3]
    
    let option4 = "Protuguese"
    let option5 = "Anmerican"
    let option6 = "Brazilian"
    let options2 = [option4, option5, option6]
    
    let correctAnswers = [question1: [option3], question2: [option4, option6]]
    
    let navigationController = UINavigationController()
    let factory = iOSViewControllerFactory(questions: questions, options: [question1: options1, question2: options2], correctAnswers: correctAnswers)
    let router = NavigationControllerRouter(navigationController, factory: factory)
    
    self.window = UIWindow(windowScene: scene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
  }

}

