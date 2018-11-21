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
        self.getGreekNewTestament()
    }
    
    fileprivate func initializeJS() {
        self.jsContext = JSContext()
        
        if let jsSourcePath = Bundle.main.path(forResource: "sampleTestament", ofType: "js") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                self.jsContext.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getGreekNewTestament() {
        if let variable = self.jsContext.objectForKeyedSubscript("newTestament") {
            print(variable.objectForKeyedSubscript("Matthew"))
        }
    }
}
