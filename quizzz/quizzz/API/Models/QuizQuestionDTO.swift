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
    let answersCorrectness: [Bool]
    let multipleCorrectAnswers: Bool
    let explanation: String
}
