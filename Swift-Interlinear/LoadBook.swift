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
    var chapterCount = 0
    var allVersesArray = [WordObject]()
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
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                if let jsonResult = jsonResult as? Array<Any> {
                    rawBookArray = jsonResult
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getBookJSON(bookArray: Array<Any>) {
        var verseCounter = 1
        chapterCount = bookArray.count
        
        for chapter in bookArray {
            guard let chapterArray = chapter as? Array<Any> else { return }

            verseCounter = 1
            
            for index in 0...chapterArray.count - 1 {
                guard let wordObject = chapterArray[index] as? Array<Any> else { return }
                
                let strongsNumber = wordObject[0] as! String
                let morphology = wordObject[1] as! String
                let verseChapter = wordObject[4] as! Int
                let verseNumber = wordObject[5] as! Int
                let originalWord = wordObject[6] as! String
                let englishWord = wordObject[7] as! String
                let phonetic = wordObject[8] as! String
                let punctuation = wordObject[9] as! String
                
                if verseNumber == verseCounter {
                    
                    if index == 0 {
                        let firstVerse = 1
                        let wordInfo = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: verseChapter, verseNumber: firstVerse, punctuation: punctuation, morphology: morphology)
                        
                        allVersesArray.append(wordInfo)
                    } else {
                        let wordInfo = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: verseChapter, verseNumber: nil, punctuation: punctuation, morphology: morphology)
                        allVersesArray.append(wordInfo)
                    }
                    
                } else if verseNumber > verseCounter {
                    verseCounter += 1
                    let wordInfo = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: verseChapter, verseNumber: verseNumber, punctuation: punctuation, morphology: morphology)
                    allVersesArray.append(wordInfo)
                }
                
                
                
            }
            
//            for wordArray in chapterArray {
//                guard let wordObject = wordArray as? Array<Any> else { return }
//
//                let strongsNumber = wordObject[0] as! String
//                let morphology = wordObject[1] as! String
//                let verseChapter = wordObject[4] as! Int
//                let verseNumber = wordObject[5] as! Int
//                let originalWord = wordObject[6] as! String
//                let englishWord = wordObject[7] as! String
//                let phonetic = wordObject[8] as! String
//                let punctuation = wordObject[9] as! String
//
//
//                if verseNumber == verseCounter {
//                    let wordInfo = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: verseChapter, verseNumber: nil, punctuation: punctuation, morphology: morphology)
//
//                    print(wordInfo.englishRendering)
//                    print(wordInfo.verseNumber)
//                    allVersesArray.append(wordInfo)
//                } else if verseNumber > verseCounter {
//                    verseCounter += 1
//                    let wordInfo = WordObject(greekOrHebrewWord: originalWord, phonetic: phonetic, strongsNumber: strongsNumber, englishRendering: englishWord, verseChapter: verseChapter, verseNumber: verseNumber, punctuation: punctuation, morphology: morphology)
//                    print(wordInfo.englishRendering)
//                    print(wordInfo.verseNumber)
//                    allVersesArray.append(wordInfo)
//                }
//            }
        }
        collectionView.reloadData()
    }
    
    fileprivate func appendToMainText() {
        _ = [String]()
    }
}

extension LoadBook: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
//        return chapterCount
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allVersesArray.count
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
        
        let item = allVersesArray[indexPath.item]
        let originalWordWidth = item.greekOrHebrewWord.width(withConstrainedHeight: 14, font: UIFont.systemFont(ofSize: 14))
        let englishWordWidth = item.englishRendering.width(withConstrainedHeight: 12, font: UIFont.systemFont(ofSize: 12))
        let phoneticWordWidth = item.phonetic.width(withConstrainedHeight: 12, font: UIFont.systemFont(ofSize: 12))
        
        if originalWordWidth >= englishWordWidth && originalWordWidth >= phoneticWordWidth {
            width = Int(originalWordWidth) + 25
        } else if englishWordWidth >= originalWordWidth && englishWordWidth >= phoneticWordWidth {
            width = Int(englishWordWidth)
            
            if width <= 35 {
                width += 20
            } else {
                width = Int(englishWordWidth)
            }
            
        } else if phoneticWordWidth >= originalWordWidth && phoneticWordWidth >= englishWordWidth {
            width = Int(phoneticWordWidth)
            if width <= 35 {
                width += 20
            } else {
                width = Int(phoneticWordWidth)
            }
            
        }
    
        let size = CGSize(width: width, height: 60)
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WordObjectCell
        
        print(allVersesArray[indexPath.item].verseNumber)
        
        guard let bookArray = rawBookArray else { return cell }
        
        for index in 0...bookArray.count {
            if indexPath.section == index {
                cell.wordObject = allVersesArray[indexPath.item]

            }
        }
        
        
        cell.wordObject = allVersesArray[indexPath.item]
        
        return cell
    }
    
}


