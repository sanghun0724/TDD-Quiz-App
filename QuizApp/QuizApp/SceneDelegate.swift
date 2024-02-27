//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by 이상헌 on 2/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  private lazy var navigationController = UINavigationController()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let viewController = QuestionViewController(question: "A question?", options: ["Option 1", "Option 2"]) {
      print($0)
    }
    _ = viewController.view
    viewController.tableView.allowsMultipleSelection = true
    self.window = UIWindow(windowScene: scene)
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
  }


}

