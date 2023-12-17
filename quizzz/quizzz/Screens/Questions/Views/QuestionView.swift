//
//  QuestionView.swift
//  quizzz
//
//  Created by Vadim Aleshin on 17.12.2023.
//

import UIKit

final class QuestionView: UIView {
    private lazy var questionLabel: UILabel = makeQuestionLabel()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ text: String) {
        questionLabel.text = text
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            questionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - Factory
extension QuestionView {
    private func makeQuestionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }
}
