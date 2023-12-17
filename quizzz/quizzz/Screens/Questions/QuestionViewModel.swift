//
//  QuestionViewModel.swift
//  quizzz
//
//  Created by Vadim Aleshin on 17.12.2023.
//

import Foundation
import FlyingEmojis

protocol QuestionViewModelDelegate: AnyObject {
    func viewModelDidUpdate(viewModel: QuestionViewModelProtocol)
    func nextQuestion(_ question: QuestionViewModel.Question)
    func questionOver(_ answer: [Bool])
}

protocol QuestionViewModelProtocol {
    func answerForQuestion(_ index: Int) -> Bool
    func nextQuestion()
    func setup()
    func getTheme() -> ParticleAnimationView.Theme?
    
    var delegate: QuestionViewModelDelegate? { get set }
}

final class QuestionViewModel {
    private let networkService: NetworkService = .shared
    weak var delegate: QuestionViewModelDelegate?
    
    private var questions: [Question]?
    private var theme: ParticleAnimationView.Theme?
    
    private var answers: [Bool] = []
    private var questionIndex: Int = 0 {
        didSet {
            updateQuestion()
        }
    }
    
    init(id: Int) {
        Task {
            let packDTO = try await networkService.getPack(with: id)
            let pack = Pack(dto: packDTO)

            questions = pack.questions.map { Question(with: $0) }
            theme = pack.getTheme()
            delegate?.viewModelDidUpdate(viewModel: self)
        }
    }
    
    private func updateQuestion() {
        guard let questionNow = questions?[safe: questionIndex] else {
            delegate?.questionOver(answers)
            return
        }
        delegate?.nextQuestion(questionNow)
    }
}

extension QuestionViewModel {
    struct Question {
        let title: String
        let answers: [String]
        let correctAnswer: [Bool]
    }
}

extension QuestionViewModel.Question {
    init(with question: QuizQuestion) {
        self.title = question.question
        self.answers = question.answers
        self.correctAnswer = question.answersCorrectness
    }
}

extension QuestionViewModel: QuestionViewModelProtocol {
    func nextQuestion() {
        questionIndex += 1
    }
    
    func answerForQuestion(_ index: Int) -> Bool {
        guard let questionNow = questions?[safe: questionIndex] else { return false }
        let flag = questionNow.correctAnswer[safe: index] ?? false
        answers.append(flag)
        return flag
    }
    
    func setup() {
        updateQuestion()
    }
    
    func getTheme() -> ParticleAnimationView.Theme? {
        return theme
    }
}
