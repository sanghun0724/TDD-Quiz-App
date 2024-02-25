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
  private var options = [String]()
  private var selection: ((String) -> Void)? = nil
  private let reuseIdentifier = "Cell"
  
  convenience init(
    question: String,
    options: [String],
    selection: @escaping (String) -> Void) {
    self.init()
    self.question = question
    self.options = options
    self.selection = selection
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.reloadData()
    headerLabel.text = question
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = dequeCell(in: tableView)
    cell.textLabel?.text = options[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selection?(options[indexPath.row])
  }
  
  private func dequeCell(in tableView: UITableView) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
      return cell
    }
    return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
  }
  
}

