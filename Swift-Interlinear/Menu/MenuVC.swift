//
//  MenuVC.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/20/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    var menuArray = [String]()
    var rawBookArray: Array<Any>?
    var menuTableView: UITableView!
    var testament: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if testament == "old" {
            navigationItem.title = "Old Testament"
        } else if testament == "new" {
            navigationItem.title = "New Testament"
        }
        
        view.backgroundColor = .white
        loadBooks(testament: testament)
        
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
    
    fileprivate func loadBooks(testament: String) {
        let testamentArray = BookAndNumbers.books
        let newTestamentArrayCount = testamentArray.count - 1
        let oldTestamentArrayCount = 37
        
        if testament == "old" {
            for index in 0...oldTestamentArrayCount {
                menuArray.append(testamentArray[index])
            }
        } else if testament == "new" {
            for index in 38...newTestamentArrayCount {
                menuArray.append(testamentArray[index])
            }
        }
    }
    
    fileprivate func initializeJS(book: String) {
        if let path = Bundle.main.path(forResource: book, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                if let jsonResult = jsonResult as? Array<Any> {
                    rawBookArray = jsonResult
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension MenuVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let btn = UIButton()
        btn.setTitle("Hello", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.tintColor = UIColor.darkGray
        btn.backgroundColor = UIColor.blue
        
        return btn
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("this is the item you selected: \(menuArray[indexPath.row])")
        initializeJS(book: menuArray[indexPath.row])
        var currentChapterCount = 1
        if let rawArray = rawBookArray {
            currentChapterCount = rawArray.count
            print("current chapter: \(currentChapterCount)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        cell.textLabel?.text = menuArray[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        cell.textLabel?.textColor = UIColor.darkGray

        return cell
    }
    
    
}
