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
    
    func initializeJS() {
        self.jsContext = JSContext()
        
        if let jsSourcePath = Bundle.main.path(forResource: "GreekTagged", ofType: "js") {
            do {
                _ = try String(contentsOfFile: jsSourcePath)
                
                self.jsContext.evaluateScript(jsSourcePath)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


