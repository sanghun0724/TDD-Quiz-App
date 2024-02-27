//
//  UITableViewExtension.swift
//  QuizApp
//
//  Created by 이상헌 on 2/27/24.
//

import UIKit

extension UITableView {
  
  func register(_ type: UITableViewCell.Type) {
    let className = String(describing: type)
    register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
  }
  
  func dequeReusableCell<T>(_ type: T.Type) -> T? {
    let className = String(describing: type)
    return dequeueReusableCell(withIdentifier: className) as? T
  }
}
