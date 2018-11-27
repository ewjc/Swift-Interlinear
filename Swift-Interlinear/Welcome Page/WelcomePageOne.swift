//
//  WelcomePageOne.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/17/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit
import JavaScriptCore

class WelcomePageOne: UIViewController {
    
    var jsContext: JSContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.initializeJS()
        self.getGreekChapter()
    }
    
    fileprivate func initializeJS() {
        self.jsContext = JSContext()
        
        if let jsSourcePath = Bundle.main.path(forResource: "FirstHalf", ofType: "json") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                self.jsContext.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getGreekChapter() {
        guard let variable = self.jsContext.objectForKeyedSubscript("matthewArray") else { return }
        print(variable.atIndex(1))
//    print(variable.objectForKeyedSubscript("Matthew")?.objectAtIndexedSubscript(0)!.objectAtIndexedSubscript(1)!)
//
//        print(variable.objectForKeyedSubscript("Matthew")?.objectAtIndexedSubscript(1)!)
    }
}
