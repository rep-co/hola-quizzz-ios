//
//  Targets.swift
//  quizzz
//
//  Created by Сергеев on 17.12.2023.
//

import Foundation

enum QuizTarget: Equatable {
    case getPackPreviews
    case getPack(id: Int)
}

extension QuizTarget {
    var baseURL: String {
        return "http://localhost:8080"
    }

    func getPath() -> String {
        switch self {
        case .getPackPreviews:
            return baseURL + "/pack"
        case let .getPack(id):
            return baseURL + "/pack/\(id)"
        }
    }
}
