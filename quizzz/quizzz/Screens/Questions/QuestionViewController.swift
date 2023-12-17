//
//  QuestionViewController.swift
//  quizzz
//
//  Created by Vadim Aleshin on 16.12.2023.
//

import UIKit
import FlyingEmojis

final class QuestionViewController: UIViewController {
    private lazy var statusView: QuestionStatusView = .init(frame: .zero)
    private lazy var questionView: QuestionView = .init()
    private lazy var answerView: AnswerView = .init()
    private lazy var emojisBackground: ParticleAnimationView = .init()
    private lazy var backButton: UIButton = makeBackButton()
    private lazy var logoImageView: UIImageView = makeLogoImageView()
    
    var viewModel: QuestionViewModelProtocol!
    var router: QuestionRouterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        addSubviews()
        setupConstraints()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emojisBackground.updateBounds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emojisBackground.isHidden = true
    }
    
    private func setup() {
        viewModel.delegate = self

        answerView.handler = { [weak self] id in
            let flag = self?.viewModel.answerForQuestion(id) ?? false
            self?.statusView.nextStep(with: flag)
            self?.viewModel.nextQuestion()
        }
        addBackgroundBlur()
    }

    private func addSubviews() {
        view.addSubview(emojisBackground)
        view.addSubview(backButton)
        view.addSubview(logoImageView)
        view.addSubview(statusView)
        view.addSubview(questionView)
        view.addSubview(answerView)
    }
    
    private func setupConstraints() {
        emojisBackground.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        statusView.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
        answerView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emojisBackground.topAnchor.constraint(equalTo: view.topAnchor),
            emojisBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            emojisBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            emojisBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backButton.heightAnchor.constraint(equalToConstant: 45),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),

            logoImageView.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 10),
            logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            logoImageView.bottomAnchor.constraint(equalTo: statusView.topAnchor, constant: -10),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            
            statusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            statusView.heightAnchor.constraint(equalToConstant: 80),
            
            questionView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 50),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionView.heightAnchor.constraint(equalTo: questionView.widthAnchor, multiplier: 0.597),
            
            answerView.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 50),
            answerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            answerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func addBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.1
        emojisBackground.addSubview(blurEffectView)
    }
    
    @objc private func didTapBackButton() {
        router.close()
    }
}

extension QuestionViewController: QuestionViewModelDelegate {
    func viewModelDidUpdate(viewModel: QuestionViewModelProtocol) {
        guard let theme = viewModel.getTheme() else { return }
        DispatchQueue.main.async { [weak self] in
            self?.emojisBackground.update(with: theme)
            viewModel.setup()
        }
    }

    func nextQuestion(_ question: QuestionViewModel.Question) {
        questionView.configure(question.title)
        answerView.configure(question.answers)
    }
    
    func questionOver(_ answer: [Bool]) {
        router.showFinishAlert(answers: answer)
    }
}

// MARK: - Factory
extension QuestionViewController {
    private func makeBackButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(.backArrowQuiz, for: .normal)
        button.layer.cornerRadius = 45.0 / 2.0
        button.layer.cornerCurve = .circular
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }
    
    private func makeLogoImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .logoQuiz
        return imageView
    }
}
