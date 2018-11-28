//
//  WordObjectDisplay.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/28/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class WordObjectDisplayVC: UIViewController {
    
    let grayView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.lightGray
        
        return v
    }()
    
    let wordObjectContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(grayView)
        grayView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        grayView.addSubview(wordObjectContainerView)
        wordObjectContainerView.anchor(top: grayView.topAnchor, left: grayView.leftAnchor, bottom: grayView.bottomAnchor, right: grayView.rightAnchor, paddingTop: 40, paddingLeft: 50, paddingBottom: 40, paddingRight: 50, width: 0, height: 0)
        
    }
    
}
