//
//  WordObjectDisplay.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/28/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class WordObjectDisplayVC: UIViewController {
    
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
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancel_button"), for: .normal)
        btn.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        return btn
    }()
    
    let grayView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        
        return v
    }()
    
    let wordObjectContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 7.0
        v.clipsToBounds = true
        
        return v
    }()
    
    let originalWordLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.rgb(148, 126, 33)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        return lbl
    }()
    
    let englishRenderedWordLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 14)
        
        return lbl
    }()
    
    let phoneticLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.rgb(59, 85, 21)
        lbl.font = UIFont.systemFont(ofSize: 14)
        
        return lbl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.addSubview(grayView)
        grayView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        grayView.addSubview(wordObjectContainerView)
        wordObjectContainerView.anchor(top: grayView.topAnchor, left: grayView.leftAnchor, bottom: grayView.bottomAnchor, right: grayView.rightAnchor, paddingTop: 70, paddingLeft: 50, paddingBottom: 70, paddingRight: 50, width: 0, height: 0)
        
        grayView.addSubview(cancelButton)
        cancelButton.anchor(top: grayView.topAnchor, left: grayView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        wordObjectContainerView.addSubview(originalWordLabel)
        originalWordLabel.anchor(top: wordObjectContainerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        originalWordLabel.centerXAnchor.constraint(equalTo: wordObjectContainerView.centerXAnchor).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: false, completion: nil)
    }
    
}
