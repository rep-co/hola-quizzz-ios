//
//  QuestionRouter.swift
//  quizzz
//
//  Created by Vadim Aleshin on 17.12.2023.
//

import UIKit

protocol QuestionRouterProtocol {
    func showFinishAlert(answers: [Bool])
    func close()
}

struct QuestionRouter {
    weak var controller: QuestionViewController?
}

// MARK: - QuestionRouterProtocol
extension QuestionRouter: QuestionRouterProtocol {
    func showFinishAlert(answers: [Bool]) {
        let alert = UIAlertController(
            title: "The End",
            message: "Question count - \(answers.count), incorrect - \(answers.filter { !$0 }.count)",
            preferredStyle: .alert
        )
        
        controller?.present(alert, animated: true)
    }
    
    func close() {
        controller?.dismiss(animated: true)
    }
}
