//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by 이상헌 on 3/2/24.
//

import Foundation
import QuizeEngine

struct ResultsPresenter {
  let result: Result<Question<String>, [String]>
  let questions: [Question<String>]
  var correctAnswers: Dictionary<Question<String>, [String]>
  
  var summary: String {
    return "You got \(result.score)/\(result.answers.count) correct"
  }
  
  var presentableAnswers: [PresentableAnswer] {
    return questions.map { (question) in
      guard let correctAnswer = correctAnswers[question],
            let userAnswer = result.answers[question] else {
        fatalError("Coudn't find correct answer for question:\(question)")
      }
      
      return presentableAnswer(question: question, userAnswer: userAnswer, correctAnswer: correctAnswer)
    }
  }
  
  private func presentableAnswer(question: Question<String>, userAnswer: [String], correctAnswer: [String]) -> PresentableAnswer {
    switch question {
    case .singleAnswer(let value), .multipleAnswer(let value):
      return PresentableAnswer(
        question: value,
        answer: formattedAnswer(correctAnswer),
        wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer)
      )
    }
  }
  
  private func formattedAnswer(_ answer: [String]) -> String {
    return answer.joined(separator: ", ")
  }
  
  private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
    return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
  }
}
