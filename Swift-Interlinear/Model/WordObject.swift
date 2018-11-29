//
//  WordObject.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/24/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import Foundation

class WordObject {
    
    var greekOrHebrewWord: String
    var phonetic: String
    var strongsNumber: String
    var englishRendering: String
    var verseChapter: Int
    var verseNumber: Int
    var punctuation: String
    var morphology: String
    
    init(greekOrHebrewWord: String, phonetic: String, strongsNumber: String, englishRendering: String, verseChapter: Int, verseNumber: Int, punctuation: String, morphology: String) {
        
        self.greekOrHebrewWord = greekOrHebrewWord
        self.phonetic = phonetic
        self.strongsNumber = strongsNumber
        self.englishRendering = englishRendering
        self.verseChapter = verseChapter
        self.verseNumber = verseNumber
        self.punctuation = punctuation
        self.morphology = morphology
    }
}
