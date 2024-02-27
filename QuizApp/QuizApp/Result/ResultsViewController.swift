//
//  Copyright © 2017 Essential Developer. All rights reserved.
//

import UIKit

struct PresentableAnswer {
  let isCorrect: Bool
}

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  private var summary = ""
  private var answers = [PresentableAnswer]()
  
  convenience init(summary: String, answers: [PresentableAnswer]) {
    self.init()
    self.summary = summary
    self.answers = answers
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerLabel.text = summary
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let answer = answers[indexPath.row]
    return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return answers.count
  }
}
