//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by 이상헌 on 3/3/24.
//

import QuizeEngine

struct QuestionPresenter {
  let questions: [Question<String>]
  let question: Question<String>
  
  var title: String? {
    guard let index = questions.index(of: question) else { return "" }
    return "Question #\(index + 1)"
  }
}
