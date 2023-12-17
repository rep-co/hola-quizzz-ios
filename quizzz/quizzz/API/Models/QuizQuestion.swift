import Foundation

struct QuizQuestion {
    let id: Int
    let question: String
    let answers: [String]
    let answersCorrectness: [Bool]
    let multipleCorrectAnswers: Bool
    let explanation: String
}

extension QuizQuestion {
    init(dto: QuizQuestionDTO) {
        self.id = dto.id
        self.question = dto.question
        self.answers = dto.answers.filter({ $0 != ""})
        self.answersCorrectness = dto.correct_answers
        self.multipleCorrectAnswers = dto.multiple_correct_answers
        self.explanation = dto.explanation
    }
}
