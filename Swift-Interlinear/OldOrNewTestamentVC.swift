//
//  OldOrNewTestamentVC.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 12/1/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class OldOrNewTestamentVC: UIViewController {
    
    var oldTestamentLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Old Testament (Original Hebrew)"
        lbl.font = UIFont.boldSystemFont(ofSize: 36)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        
        return lbl
    }()
    
    var newTestamentLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "New Testament (Koine Greek)"
        lbl.font = UIFont.boldSystemFont(ofSize: 36)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let oldTap = UITapGestureRecognizer(target: self, action: #selector(handleOldTapped))
        view.addSubview(oldTestamentLabel)
        oldTestamentLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 150, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        oldTestamentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        oldTestamentLabel.addGestureRecognizer(oldTap)

        
        let newTap = UITapGestureRecognizer(target: self, action: #selector(handleNewTapped))
        view.addSubview(newTestamentLabel)
        newTestamentLabel.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 150, paddingRight: 40, width: 0, height: 0)
        newTestamentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTestamentLabel.addGestureRecognizer(newTap)
    }
    
    @objc func handleOldTapped() {
        print("tapped old")
    }
    
    @objc func handleNewTapped() {
         print("tapped new")
    }
    
}
