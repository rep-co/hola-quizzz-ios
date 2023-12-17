//
//  ViewController.swift
//  quizzz
//
//  Created by Vadim Aleshin on 16.12.2023.
//

import UIKit
import FlyingEmojis

final class MainScreenViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    var data: [MainScreenCell.Info] = []
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView()
    private let emojisBackground = ParticleAnimationView()
    private let layout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubvievs()
        setupConstraints()
        setupLayout()
        setupTitleLabel()
        setupImageView()
        setupEmojisBackground()
        setupCollectionView()

        connectionDidFinishLoading { questions in
            for i in questions {
                self.data.append(.init(title: i.name, description: i.description))
            }
        }
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
        logoImageView.image = .logo
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
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCell.identifier, for: indexPath) as? MainScreenCell
        else { return UICollectionViewCell() }
        cell.data = self.data[indexPath.row]
        return cell
    }
}

extension MainScreenViewController {
    enum Text: String {
       case selectPack = "SELECT PACK"
    }
}
