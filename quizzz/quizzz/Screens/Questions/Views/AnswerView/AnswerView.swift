//
//  AnswerView.swift
//  quizzz
//
//  Created by Vadim Aleshin on 17.12.2023.
//

import UIKit

final class AnswerView: UIView {
    var handler: ((Int) -> Void)?
    
    private lazy var stackView: UIStackView = makeStackView()
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configure(_ answers: [String]) {
        let cellViewModels = answers.enumerated().map {
            AnswerViewCell.ViewModel(
                id: $0.offset,
                title: $0.element
            )
        }
        
        let cells = cellViewModels.map { AnswerViewCell($0) }
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cells.forEach {
            $0.handler = { [weak self] id in
                self?.handler?(id)
            }
            stackView.addArrangedSubview($0)
        }
    }
}

// MARK: - Factory
extension AnswerView {
    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis =  .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }
}
