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

class LoadBook: UICollectionViewController {
    var bookChapterArray = [[[WordObject]]]()
    var chapterArray = [[WordObject]]()
    var verseArray = [WordObject]()
    var greekTexts: String?
    var verseCounter = 1
    
    var jsContext: JSContext!
    
    fileprivate func setupTextView() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(WordObjectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        self.initializeJS()
        self.getBookJSON()
        self.appendToMainText()
    }
    
    fileprivate func initializeJS() {
        self.jsContext = JSContext()
        
        if let jsSourcePath = Bundle.main.path(forResource: "Matthew", ofType: "json") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                self.jsContext.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getBookJSON() {
        guard let variable = self.jsContext.objectForKeyedSubscript("matthewArray") else { return }
        guard let variableAarry = variable.toArray() else { return }
        
        for index in 0...variableAarry.count - 1 {
            for jsWordObject in (variable.atIndex(index)?.toArray())! {
                guard let jsWordObjectArray = jsWordObject as? Array<Any> else { return }
                
                let originalWord = jsWordObjectArray[10] as! String
                let englishWord = jsWordObjectArray[11] as! String
                let phonetic = jsWordObjectArray[12] as! String
                let strongsNumber = jsWordObjectArray[0] as! String
                let morphology = jsWordObjectArray[1] as! String
                let chapterNumber = jsWordObjectArray[8] as!  Int
                let verseNumber = jsWordObjectArray[9] as! Int
                let punctuation = jsWordObjectArray[13] as! String
                
                let wordObject = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: chapterNumber, verseNumber: verseNumber, punctuation: punctuation, morphology: morphology)
//
                if chapterNumber == chapterCounter {


                } else if chapterNumber > chapterCounter {

                }

            }
        }
    }
    
    fileprivate func sortChapter(chapterNumber: Int) {
        var chapterCounter = 1
        if chapterNumber == chapterCounter {
            
        }
    }
    
    fileprivate func sortVerse(verseNumber: Int, wordObject: WordObject) {
        if verseNumber == verseCounter {
            self.verseArray.append(wordObject)
        } else if verseNumber > verseCounter {
            self.chapterArray.append(verseArray)
            self.verseArray.removeAll()
            verseCounter += 1
            self.verseArray.append(wordObject)
        } else if verseNumber < verseCounter {
            self.bookChapterArray.append(chapterArray)
            self.chapterArray.removeAll()
            verseCounter = 1
        }
    }
    
    fileprivate func appendToMainText() {
        var totalText = [String]()
        for chapter in bookChapterArray {
            for verse in chapter {
                for wordObject in verse {
                    totalText.append("\(wordObject) ")
                }
            }
        }
    }
}

extension LoadBook: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let displayVC = WordObjectDisplayVC()
//        displayVC.wordObject = chapterArray[indexPath.item]
//        displayVC.modalPresentationStyle = .overFullScreen
//        self.present(displayVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = 100
//        let item = chapterArray[indexPath.item]
//        let originalWordWidth = item.greekOrHebrewWord.width(withConstrainedHeight: 14, font: UIFont.systemFont(ofSize: 14))
//        let englishWordWidth = item.englishRendering.width(withConstrainedHeight: 12, font: UIFont.systemFont(ofSize: 12))
//        let phoneticWordWidth = item.phonetic.width(withConstrainedHeight: 12, font: UIFont.systemFont(ofSize: 12))
//
//        if originalWordWidth >= englishWordWidth && originalWordWidth >= phoneticWordWidth {
//            width = Int(originalWordWidth)
//        } else if englishWordWidth >= originalWordWidth && englishWordWidth >= phoneticWordWidth {
//            width = Int(englishWordWidth)
//        } else if phoneticWordWidth >= originalWordWidth && phoneticWordWidth >= englishWordWidth {
//            width = Int(phoneticWordWidth)
//        }
        
        let size = CGSize(width: width, height: 60)

        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WordObjectCell
        
//        cell.wordObject = chapterArray[indexPath.item]
        
        return cell
    }
    
}


