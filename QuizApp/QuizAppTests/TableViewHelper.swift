//
//  TableViewHelper.swift
//  QuizAppTests
//
//  Created by 이상헌 on 2/27/24.
//

import UIKit

extension UITableView {
  func cell(at row: Int) -> UITableViewCell? {
    return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
  }
  
  func title(at row: Int) -> String? {
    cell(at: row)?.textLabel?.text
  }
  
  func select(row: Int) {
    let indexPath = IndexPath(row: row, section: 0)
    selectRow(at: indexPath, animated: false, scrollPosition: .none)
    delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
  }
  
  func deselect(row: Int) {
    let indexPath = IndexPath(row: row, section: 0)
    deselectRow(at: indexPath, animated: false)
    delegate?.tableView?(self, didDeselectRowAt: IndexPath(row: row, section: 0))
  }
}
