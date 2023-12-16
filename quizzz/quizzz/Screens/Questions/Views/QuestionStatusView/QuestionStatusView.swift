//
//  QuestionStatusView.swift
//  quizzz
//
//  Created by Vadim Aleshin on 16.12.2023.
//

import UIKit

final class QuestionStatusView: UIView {
    
    private var answerTypes: [QuestionStatusCellType] = []
    private let emptyTypes: [QuestionStatusCellType] = .init(repeating: .empty, count: 7)
    
    private lazy var collectionView: UICollectionView = makeCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nextStep(with flag: Bool) {
        answerTypes.append(flag ? .success : .error)
        collectionView.reloadData()
        let indexPath = IndexPath(row: answerTypes.count, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.register(
            QuestionStatusCollectionViewCell.self,
            forCellWithReuseIdentifier: "QuestionStatusCollectionViewCell"
        )
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "default"
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

// MARK: - FlowLayout Delegate
extension QuestionStatusView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.row {
        case 0..<answerTypes.count:
            return Const.Size.small
        case answerTypes.count:
            return Const.Size.big
        default:
            return Const.Size.small
        }
    }
}

// MARK: - CollectionView Delegate
extension QuestionStatusView: UICollectionViewDelegate {}

// MARK: - CollectionView DataSource
extension QuestionStatusView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return answerTypes.count + 1 + emptyTypes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "QuestionStatusCollectionViewCell",
            for: indexPath
        ) as? QuestionStatusCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let allTypes = answerTypes + [.selected] + emptyTypes
        let row = indexPath.row
        cell.configure(with: allTypes[safe: indexPath.row] ?? .empty, row: row)
        
        return cell
    }
}

// MARK: - Factory
extension QuestionStatusView {
    private func makeCollectionView() -> UICollectionView {
        let layout = TopAlignedCollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: self.bounds,
            collectionViewLayout: layout
        )
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
        layout.scrollDirection = .horizontal
        return collectionView
    }
}

// MARK: - Const
extension QuestionStatusView {
    private struct Const {
        struct Size {
            static let small = CGSize(width: 40, height: 60)
            static let big = CGSize(width: 60, height: 80)
        }
    }
}
