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
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in close() }))

        controller?.present(alert, animated: true)
    }
    
    func close() {
        controller?.navigationController?.popViewController(animated: true)
    }
}
