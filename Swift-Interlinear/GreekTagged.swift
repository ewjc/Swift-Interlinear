//
//  GreekTagged.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/20/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit
import JavaScriptCore

class GreekTagged: UIViewController {
    var jsContext: JSContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeJS()
        self.getGreekNewTestament()
    }
    
    fileprivate func initializeJS() {
        self.jsContext = JSContext()
        
        if let jsSourcePath = Bundle.main.path(forResource: "GNT", ofType: "json") {
            do {
                _ = try String(contentsOfFile: jsSourcePath)
                
                self.jsContext.evaluateScript(jsSourcePath)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getGreekNewTestament() {
        if let variable = self.jsContext.objectForKeyedSubscript("result") {
            print(variable.toString())
        }
    }

}


