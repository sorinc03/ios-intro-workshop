//
//  ViewController.swift
//  intro-to-ios
//
//  Created by Sorin Cioban on 19/11/2019.
//  Copyright © 2019 Sorin Cioban. All rights reserved.
//

import UIKit

class PuppyCell: UICollectionViewCell {
    let imageView = UIImageView()
    var puppy: Puppy? {
        didSet {
            imageView.image = UIImage(named: puppy?.imageName ?? "")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor), contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor), contentView.topAnchor.constraint(equalTo: imageView.topAnchor), contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
class ViewController: UIViewController, UICollectionViewDataSource {
    var collectionView: UICollectionView?
    let puppyCellIdentifier = "puppyCellIdentifier"
    var puppies: [Puppy]!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Puppies"
        view.backgroundColor = .white

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.minimumInteritemSpacing = 10.0

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.dataSource = self
        collectionView?.register(PuppyCell.self, forCellWithReuseIdentifier: puppyCellIdentifier)
        collectionView?.backgroundColor = .clear
        guard let collectionView = collectionView else {
            return
        }

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor), view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor), view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor), view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)])

        if let puppyObjects = PuppyManager()?.puppies {
            puppies = puppyObjects
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puppies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: puppyCellIdentifier, for: indexPath) as! PuppyCell
        cell.puppy = puppies[indexPath.item]
        return cell
    }
}

