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
    var rawBookArray: Array<Any>?
    
    fileprivate func setupTextView() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(WordObjectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        self.initializeJS()
        if let dataArray = rawBookArray {
            self.getBookJSON(bookArray: dataArray)
            //        self.appendToMainText()
        }

    }
    
    fileprivate func initializeJS() {
        
        if let path = Bundle.main.path(forResource: "Mark", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                print(data)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                if let jsonResult = jsonResult as? Array<Any> {
                    rawBookArray = jsonResult
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    fileprivate func sortVerse(verseNumber: Int, wordObject: WordObject) {
        var verseCounter = 1
        
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
    
    fileprivate func getBookJSON(bookArray: Array<Any>) {
        for chapter in bookArray {
            guard let chapterArray = chapter as? Array<Any> else { return }
            
            for verseArray in chapterArray {
                guard let verse = verseArray as? Array<Any> else { return }
                
                let strongsNumber = verse[0] as! String
                let morphology = verse[1] as! String
                let verseChapter = verse[3] as! Int
                let verseNumber = verse[4] as! Int
                let originalWord = verse[6] as! String
                let phonetic = verse[7] as! String
                let englishWord = verse[8] as! String
                let punctuation = verse[9] as! String
                
                let wordInfo = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: verseChapter, verseNumber: verseNumber, punctuation: punctuation, morphology: morphology)
                
                self.verseArray.append(wordInfo)
                print(wordInfo)
//                sortVerse(verseNumber: verseNumber, wordObject: wordInfo)
            }
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


