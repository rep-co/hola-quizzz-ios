//
//  ViewController.swift
//  quizzz
//
//  Created by Vadim Aleshin on 16.12.2023.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    private var collection: UICollectionView?
    
    
    private let label = UILabel()
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubvievs()
        setupConstraints()
        setupLable()
        setupImageView()

    }

    func setupLable(){
        label.textColor = .black
        label.text = "выбери набор"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40)
    }
    
    func setupImageView(){
//        imageView.image = .logo
    }
    
    func addSubvievs(){
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        view.addSubview(label)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 90),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -90),
            imageView.heightAnchor.constraint(equalToConstant:140),
            
            label.heightAnchor.constraint(equalToConstant:45),
            label.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            label.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 90)
            
        ])
    }
}

extension MainScreenViewController{
    
//    func setupCollectionView(){
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
    
}

//
//extension MainScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
