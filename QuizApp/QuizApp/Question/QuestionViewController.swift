//
//  ViewController.swift
//  QuizApp
//
//  Created by 이상헌 on 2/11/24.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  private var question: String = ""
  private var options: [String] = []
  
  convenience init(question: String, options: [String]) {
    self.init()
    self.question = question
    self.options = options
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerLabel.text = question
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    options.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =  UITableViewCell()
    cell.textLabel?.text = options[indexPath.row]
    return cell
  }

}

