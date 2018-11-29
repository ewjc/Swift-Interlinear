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
            phoneticLabel.text = phonetic
            englishRenderedWordLabel.text = englishWord
            
            
        }
    }
    
    let originalWordLabel: UILabel = {
       let lbl = UILabel()
        lbl.textColor = UIColor.rgb(148, 126, 33)
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        return lbl
    }()
    
    let englishRenderedWordLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 12)
        
        return lbl
    }()
    
    let phoneticLabel: UILabel = {
        let lbl = UILabel()
//        lbl.textColor = UIColor.darkGray
        lbl.textColor = UIColor.rgb(59, 85, 21)
        lbl.font = UIFont.systemFont(ofSize: 12)
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(originalWordLabel)
        originalWordLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        originalWordLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.addSubview(phoneticLabel)
        phoneticLabel.anchor(top: originalWordLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        phoneticLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.addSubview(englishRenderedWordLabel)
        englishRenderedWordLabel.anchor(top: phoneticLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        englishRenderedWordLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
