//
//  QuestionStatusCollectionViewCell.swift
//  quizzz
//
//  Created by Vadim Aleshin on 16.12.2023.
//

import UIKit

final class QuestionStatusCollectionViewCell: UICollectionViewCell {
    private(set) var type: QuestionStatusCellType = .empty {
        didSet {
            didChangeType(oldValue: oldValue, newValue: type)
        }
    }
    
    private(set) var row: Int = 0 {
        didSet {
            didChangeRow()
        }
    }
    
    private lazy var numberLabel: UILabel = makeNumberLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with type: QuestionStatusCellType, row: Int) {
        self.type = type
        self.row = row
    }
    
    private func didChangeType(oldValue: QuestionStatusCellType, newValue: QuestionStatusCellType) {
        redrawCell(oldValue: oldValue, newValue: newValue)
    }
    
    private func didChangeRow() {
        numberLabel.text = "\(row + 1)"
    }
    
    private func redrawCell(oldValue: QuestionStatusCellType, newValue: QuestionStatusCellType) {
        setupForType(newValue)
    }
    
    private func setupForType(_ type: QuestionStatusCellType) {
        switch type {
        case .success:
            backgroundColor = .repcoGreen
            numberLabel.isHidden = true
        case .error:
            backgroundColor = .repcoRed
            numberLabel.isHidden = true
        case .selected:
            backgroundColor = .white
            numberLabel.isHidden = false
        case .empty:
            backgroundColor = .white.withAlphaComponent(0.6)
            numberLabel.isHidden = true
        }
    }
}

// MARK: - Setup UI
extension QuestionStatusCollectionViewCell {
    private func setupUI() {
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
        
        setupForType(.empty)
    }
    
    private func setupConstraints() {
        contentView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

// MARK: - Factory
extension QuestionStatusCollectionViewCell {
    private func makeNumberLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
}
