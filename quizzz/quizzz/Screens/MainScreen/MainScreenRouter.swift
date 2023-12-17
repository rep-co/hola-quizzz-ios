import UIKit

protocol MainRouter {
    func openQuizViewController(with id: Int)
}

struct MainRouterImpl {
    weak var controller: MainScreenViewController?
}

// MARK: - MainRouter
extension MainRouterImpl: MainRouter {
    func openQuizViewController(with id: Int) {
        let viewModel = QuestionViewModel(id: id)
        let quizController = QuestionViewController()
        let quizRouter = QuestionRouter(controller: quizController)
        quizController.router = quizRouter
        quizController.viewModel = viewModel

        controller?.navigationController?.pushViewController(quizController, animated: true)
    }
}
