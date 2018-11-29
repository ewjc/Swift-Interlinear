//
//  MenuVC.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/20/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    let menuArray = BookAndNumbers.books
    var menuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "The Scriptures"
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        menuTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        menuTableView.delegate = self
        menuTableView.dataSource = self
        view.addSubview(menuTableView)
        menuTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    @objc func handleBookTapped() {
        let index = NSIndexPath(item: 0, section: 0)
        let cell = menuTableView.cellForRow(at: index as IndexPath)
        print("this is the text label: \(String(describing: cell?.textLabel?.text))")
    }

}

extension MenuVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else {
//            return menuArray.count
//        }
        
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        let tapBookTitle = UITapGestureRecognizer(target: self, action: #selector(handleBookTapped))
        
        cell.textLabel?.text = menuArray[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.addGestureRecognizer(tapBookTitle)
        cell.textLabel?.isUserInteractionEnabled = true
        
        return cell
    }
    
    
}
