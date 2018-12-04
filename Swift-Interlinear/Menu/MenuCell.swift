//
//  MenuCell.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/20/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    var versesCollectionView = UICollectionView()

}

extension MenuCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        versesCollectionView.delegate = dataSourceDelegate
        versesCollectionView.dataSource = dataSourceDelegate
        versesCollectionView.tag = row
        versesCollectionView.setContentOffset(versesCollectionView.contentOffset, animated: false)
        versesCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { versesCollectionView.contentOffset.x = newValue }
        get { return versesCollectionView.contentOffset.x }
    }
}
