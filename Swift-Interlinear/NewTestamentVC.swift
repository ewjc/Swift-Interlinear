//
//  NewTestamentVC.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 12/1/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class NewTestamentVC: UIViewController {
    
    var bookArray = [String]()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        navigationItem.title = "New Testament"
        view.backgroundColor = .white
        loadBooks()
        print(bookArray)
    }
    
    fileprivate func loadBooks() {
        let newTestamentArray = BookAndNumbers.books
        let newTestamentArrayCount = newTestamentArray.count - 1
        
        for index in 38...newTestamentArrayCount {
            bookArray.append(newTestamentArray[index])
        }
    }
    
}

