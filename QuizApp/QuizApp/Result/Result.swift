//
//  Result.swift
//  QuizApp
//
//  Created by 이상헌 on 2/29/24.
//

import Foundation

struct Result<Question: Hashable, Answer> {
  let answers: [Question: Answer]
  let score: Int
}
