//
//  ViewController.swift
//  quizzz
//
//  Created by Vadim Aleshin on 16.12.2023.
//

import UIKit
import FlyingEmojis

final class MainScreenViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    private var packPreviews: [PackPreview]?
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView()
    private let emojisBackground = ParticleAnimationView()
    private let layout = UICollectionViewFlowLayout()
    private let networkService: NetworkService = .shared
    var router: MainRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let packPreviewsDTO = try await networkService.getPackPreviews()
            packPreviews = packPreviewsDTO.map { PackPreview(dto: $0) }
            collectionView.reloadData()
        }
        view.backgroundColor = .white
        addSubvievs()
        setupConstraints()
        setupLayout()
        setupTitleLabel()
        setupImageView()
        setupEmojisBackground()
        setupCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emojisBackground.updateBounds()
    }

    func setupTitleLabel(){
        titleLabel.textColor = .black
        titleLabel.text = Text.selectPack.rawValue
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30)
    }

    func setupImageView(){
        logoImageView.image = .logoQuiz
    }

    func addSubvievs(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        emojisBackground.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emojisBackground)
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            emojisBackground.topAnchor.constraint(equalTo: view.topAnchor),
            emojisBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            emojisBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            emojisBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            logoImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 90),
            logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -90),
            logoImageView.heightAnchor.constraint(equalToConstant:140),

            titleLabel.heightAnchor.constraint(equalToConstant:45),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 90),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

// MARK: - Private Methods -
private extension MainScreenViewController {
    func setupLayout() {
        layout.itemSize = CGSize(width: view.frame.size.width/1.2, height: view.frame.size.width/4)
        layout.scrollDirection = .vertical
    }

    func setupEmojisBackground() {
        emojisBackground.update(with: .init(mainImage: "🤡".toImage(),
                                            secondaryImage: "🎪".toImage(),
                                            tertiaryImage: "🎠".toImage()))
    }

    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(MainScreenCell.self, forCellWithReuseIdentifier: MainScreenCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension MainScreenViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packPreviews?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCell.identifier,
                                                            for: indexPath) as? MainScreenCell,
              let packPreviews,
              let packPreview = packPreviews[safe: indexPath.row] else { return UICollectionViewCell() }
        cell.data = .init(title: packPreview.name, description: packPreview.description)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = packPreviews?[indexPath.row].id else { return }
        router.openQuizViewController(with: id)
    }
}

extension MainScreenViewController {
    enum Text: String {
       case selectPack = "SELECT PACK"
    }
}
