//
//  CollectionViewTableViewCell.swift
//  Bambook
//
//  Created by Диас Сайынов on 15.01.2024.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell, CollectionViewProtocol {
    static let identifier = "CollectionViewTableViewCell"
    private var books: [BookData] = [BookData]()
    var presenter: FeedPresenterProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        layout.collectionView?.showsHorizontalScrollIndicator = false
        layout.collectionView?.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        return collectionView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
            
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    public func configure(with books: [BookData]){
        self.books = books
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        books[indexPath.row].thumbnail.replace("http://", with: "https://")
        cell.configure(with: books[indexPath.row].thumbnail)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter = presenter else {
            return
        }
        presenter.didSelectTitleSection(book: books[indexPath.row])
    }
}
