//
//  GreekTagged.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/20/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit
import JavaScriptCore

private let reuseIdentifier = "Cell"

class GreekTagged: UICollectionViewController {
    
    var matthewArray = [WordObject]()
    var greekTexts: String?
    
    var jsContext: JSContext!
    
    fileprivate func setupTextView() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(WordObjectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        self.initializeJS()
        self.getGreekChapter()
        self.appendToMainText()
        
        
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
    }
    
    fileprivate func appendToMainText() {
        var totalText = [String]()
        for originalWord in matthewArray {
            totalText.append("\(originalWord.englishRendering) ")
        }
    }
}

extension GreekTagged: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matthewArray.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let displayVC = WordObjectDisplayVC()
        self.present(displayVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = 100
        let item = matthewArray[indexPath.item]
        let originalWordWidth = item.greekOrHebrewWord.width(withConstrainedHeight: 14, font: UIFont.systemFont(ofSize: 14))
        let englishWordWidth = item.englishRendering.width(withConstrainedHeight: 12, font: UIFont.systemFont(ofSize: 12))
        let phoneticWordWidth = item.phonetic.width(withConstrainedHeight: 12, font: UIFont.systemFont(ofSize: 12))
        
        if originalWordWidth >= englishWordWidth && originalWordWidth >= phoneticWordWidth {
            width = Int(originalWordWidth)
        } else if englishWordWidth >= originalWordWidth && englishWordWidth >= phoneticWordWidth {
            width = Int(englishWordWidth)
        } else if phoneticWordWidth >= originalWordWidth && phoneticWordWidth >= englishWordWidth {
            width = Int(phoneticWordWidth)
        }
        
        let size = CGSize(width: width, height: 60)

        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WordObjectCell
        
        cell.wordObject = matthewArray[indexPath.item]
        
        return cell
    }
    
}


