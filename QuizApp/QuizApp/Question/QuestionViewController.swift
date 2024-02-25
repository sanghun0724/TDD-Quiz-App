//
//  ViewController.swift
//  QuizApp
//
//  Created by 이상헌 on 2/11/24.
//

import UIKit

class QuestionViewController: UIViewController {
  
  private var question: String = ""
  
  convenience init(question: String) {
    self.init()
    self.question = question
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("shlee")
  }


}

