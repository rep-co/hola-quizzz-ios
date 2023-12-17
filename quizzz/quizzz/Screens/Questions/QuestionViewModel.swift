//
//  QuestionViewModel.swift
//  quizzz
//
//  Created by Vadim Aleshin on 17.12.2023.
//

import Foundation

protocol QuestionViewModelDelegate: AnyObject {
    func nextQuestion(_ question: QuestionViewModel.Question)
    func questionOver(_ answer: [Bool])
}

protocol QuestionViewModelProtocol {
    func answerForQuestion(_ index: Int) -> Bool
    func nextQuestion()
    func setup()
    
    var delegate: QuestionViewModelDelegate? { get set }
}

final class QuestionViewModel {
    weak var delegate: QuestionViewModelDelegate?
    
    private let questions: [Question]
    
    private var answers: [Bool]
    private var questionIndex: Int {
        didSet {
            updateQuestion()
        }
    }
    
    struct Question {
        let title: String
        let answers: [String]
        let correctAnswer: [Bool]
    }
    
    init() {
        self.answers = []
        self.questionIndex = 0
        self.questions = [
            .init(
                title: "Кто любит бибки?",
                answers: ["Ваня", "Сережа", "Саня", "Кто то"],
                correctAnswer: [true, false, false, false]
            ),
            .init(
                title: "Кто любит попки?",
                answers: ["Ваня", "Сережа", "Саня"],
                correctAnswer: [false, true, false]
            ),
            .init(
                title: "Кто любит мам?",
                answers: ["Ваня", "Сережа"],
                correctAnswer: [true, true]
            ),
        ]
    }
    
    private func updateQuestion() {
        guard let questionNow = questions[safe: questionIndex] else {
            delegate?.questionOver(answers)
            return
        }
        delegate?.nextQuestion(questionNow)
    }
}

extension QuestionViewModel: QuestionViewModelProtocol {
    func nextQuestion() {
        questionIndex += 1
    }
    
    func answerForQuestion(_ index: Int) -> Bool {
        guard let questionNow = questions[safe: questionIndex] else { return false }
        let flag = questionNow.correctAnswer[safe: index] ?? false
        answers.append(flag)
        return flag
    }
    
    func setup() {
        updateQuestion()
    }
}
