//
//  WelcomePageFour.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/20/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class WelcomePageFour: UIViewController {
    
    let doneButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Begin your study", for: UIControl.State.normal)
        btn.setTitleColor(.white, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(handleDone), for: UIControl.Event.touchUpInside)
        btn.backgroundColor = UIColor.bambooGreen
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(doneButton)
        doneButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 60, paddingRight: 50, width: 0, height: 50)
    }
    
    @objc func handleDone() {
        let vc = UINavigationController(rootViewController: MenuVC())
        self.present(vc, animated: true, completion: nil)
    }
    
}
