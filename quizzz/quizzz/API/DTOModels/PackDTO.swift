//
//  PackDTO.swift
//  quizzz
//
//  Created by Сергеев on 17.12.2023.
//

import Foundation

struct PackDTO: Decodable {
    let id: Int
    let name: String
    let description: String
    let category: String
    let emojis: String
    let questions: [QuizQuestionDTO]
}
