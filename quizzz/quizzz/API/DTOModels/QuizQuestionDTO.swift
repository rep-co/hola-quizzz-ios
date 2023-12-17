//
//  QuizQuestion.swift
//  quizzz
//
//  Created by Сергеев on 17.12.2023.
//

import Foundation

struct QuizQuestionDTO: Decodable {
    let id: Int
    let question: String
    let description: String
    let answers: [String]
    let correct_answers: [Bool]
    let multiple_correct_answers: Bool
    let explanation: String
}
