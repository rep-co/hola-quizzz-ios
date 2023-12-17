//
//  AnswerViewCell.swift
//  quizzz
//
//  Created by Vadim Aleshin on 17.12.2023.
//

import UIKit

final class AnswerViewCell: UIControl {
    
    struct ViewModel {
        let id: Int
        let title: String
    }
    
    var handler: ((Int) -> Void)?
    let viewModel: ViewModel
    
    private lazy var titleLabel: UILabel = makeTitleLabel()
    
    init(_ model: ViewModel) {
        self.viewModel = model
        super.init(frame: .zero)

        setupUI()
        setupConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func addTargets() {
        addTarget(
            self,
            action: #selector(didTapSomeView),
            for: .touchUpInside
        )
    }
    
    @objc private func didTapSomeView() {
        handler?(viewModel.id)
    }
}

// MARK: - Factory
extension AnswerViewCell {
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        label.text = viewModel.title
        label.textAlignment = .center
        return label
    }
}

