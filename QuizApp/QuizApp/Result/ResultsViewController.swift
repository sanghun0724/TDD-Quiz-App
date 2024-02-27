//
//  Copyright © 2017 Essential Developer. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
    private var summary = ""
    
    convenience init(summary: String) {
        self.init()
        self.summary = summary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = summary
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
