//
//  File.swift
//  
//
//  Created by 이상헌 on 3/3/24.
//

import Foundation

public enum Question<T: Hashable>: Hashable {
  case singleAnswer(T)
  case multipleAnswer(T)
  
  public var hashValue: Int {
    switch self {
    case .singleAnswer(let value):
      return value.hashValue
    case .multipleAnswer(let value):
      return value.hashValue
    }
  }
}
