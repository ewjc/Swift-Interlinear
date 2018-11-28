//
//  WordObjectCell.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/27/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class WordObjectCell: UICollectionViewCell {
    
    var wordObject: WordObject? {
        didSet {
            guard let originalWord = wordObject?.greekOrHebrewWord else { return }
            guard let englishWord = wordObject?.englishRendering else { return }
            guard let phonetic = wordObject?.phonetic else { return }
            
            originalWordLabel.text = originalWord
            englishRenderedWordLabel.text = englishWord
            phoneticLabel.text = phonetic
        }
    }
    
    let originalWordLabel: UILabel = {
       let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        
        return lbl
    }()
    
    let englishRenderedWordLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.yellow
        
        return lbl
    }()
    
    let phoneticLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(originalWordLabel)
        originalWordLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.addSubview(englishRenderedWordLabel)
        englishRenderedWordLabel.anchor(top: originalWordLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        self.backgroundColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
