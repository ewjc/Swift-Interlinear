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
    
    var matthewArray = [WordObject]()
    
    var textView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 10)
        
        return tv
    }()
    
    var jsContext: JSContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.initializeJS()
        self.getGreekChapter()
        
        view.addSubview(textView)
        textView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
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
        
        for jsWordObject in (variable.atIndex(0)?.toArray())! {
            guard let jsWordObjectArray = jsWordObject as? Array<Any> else { return }
            
            let originalWord = jsWordObjectArray[10] as! String
            let englishWord = jsWordObjectArray[11] as! String
            let phonetic = jsWordObjectArray[12] as! String
            let strongsNumber = jsWordObjectArray[0] as! String
            let morphology = jsWordObjectArray[1] as! String
            let chapter = jsWordObjectArray[7] as!  Int
            let verseNumber = jsWordObjectArray[8] as! Int
            let punctuation = jsWordObjectArray[13] as! String
            
            let wordObject = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: chapter, verseNumber: verseNumber, punctuation: punctuation, morphology: morphology)
            
            matthewArray.append(wordObject)
        }
        
        //    print(variable.objectForKeyedSubscript("Matthew")?.objectAtIndexedSubscript(0)!.objectAtIndexedSubscript(1)!)
        //
        //        print(variable.objectForKeyedSubscript("Matthew")?.objectAtIndexedSubscript(1)!)
    }

}


