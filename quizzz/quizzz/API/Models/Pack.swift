import Foundation
import FlyingEmojis

struct Pack {
    let id: Int
    let name: String
    let description: String
    let emojis: String
    let questions: [QuizQuestion]
}

extension Pack {
    init(dto: PackDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.emojis = dto.emojis
        self.questions = dto.questions.map { QuizQuestion(dto: $0) }
    }
}

extension Pack {
    func getTheme() -> ParticleAnimationView.Theme {
        var theme: ParticleAnimationView.Theme
        let elements = Array(emojis)
        let stringElements = elements.map { String($0) }

        theme = .init(mainImage: (stringElements[safe: 0] ?? "🐞").toImage(),
                      secondaryImage: (stringElements[safe: 1] ?? "🐞").toImage(),
                      tertiaryImage: (stringElements[safe: 2] ?? "🐞").toImage())
        return theme
    }
}
