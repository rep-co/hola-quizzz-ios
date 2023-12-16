//
//  ViewController.swift
//  quizzz
//
//  Created by Vadim Aleshin on 16.12.2023.
//

import UIKit
import FlyingEmojis

final class MainScreenViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    
    let data = [
        MainScreenCell.Info(title: "sdfg", description: "gfd" ),
        MainScreenCell.Info(title: "String", description: "fd" ),
        MainScreenCell.Info(title: "String", description: "fdfd" ),
        MainScreenCell.Info(title: "hgfd", description: "fds" ),
        MainScreenCell.Info(title: "dfg", description: "gfd" ),
        
    ]
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
//    private var collectionView = UICollectionView(frame: .zero,
//                                                  collectionViewLayout: UICollectionViewLayout())
    private let label = UILabel()
    private let imageView = UIImageView()
    private let emojisBackground = ParticleAnimationView()
    private let layout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubvievs()
        setupConstraints()
        setupLayout()
        setupLable()
        setupImageView()
        setupEmojisBackground()
        setupCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emojisBackground.updateBounds()

    }

    func setupLable(){
        label.textColor = .black
        label.text = "SELECT PACK"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
    }
    
    func setupImageView(){
        imageView.image = .logo
    }
    
    func addSubvievs(){
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        emojisBackground.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emojisBackground)
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            emojisBackground.topAnchor.constraint(equalTo: view.topAnchor),
            emojisBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            emojisBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            emojisBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 90),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -90),
            imageView.heightAnchor.constraint(equalToConstant:140),
            
            label.heightAnchor.constraint(equalToConstant:45),
            label.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            label.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 90),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 10),
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
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCell.identifier, for: indexPath)as! MainScreenCell
        cell.data = self.data[indexPath.row]
        return cell
    }
}
