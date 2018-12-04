//
//  MenuCell.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/20/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    var versesCollectionView = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MenuCell")
    }
//
//    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, customString: String) {
//        super.init(style: style, reuseIdentifier: "MenuCell")
//
//    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
}

extension MenuCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        versesCollectionView.collectionView.dataSource = dataSourceDelegate
        versesCollectionView.collectionView.delegate = dataSourceDelegate
        versesCollectionView.collectionView.tag = row
        versesCollectionView.collectionView.setContentOffset(versesCollectionView.collectionView.contentOffset, animated: false)
        versesCollectionView.collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { versesCollectionView.collectionView.contentOffset.x = newValue }
        get { return versesCollectionView.collectionView.contentOffset.x }
    }
}
