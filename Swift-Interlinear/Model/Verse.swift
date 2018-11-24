//
//  Verse.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/24/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import Foundation

class Verse {
    var bookNumber : Int
    var chapterNumber : Int
    var verses : [WordObject]
    
    init(bookNumber: Int, chapterNumber: Int, verses: [WordObject]) {
        self.bookNumber = bookNumber
        self.chapterNumber = chapterNumber
        self.verses = verses
    }
}
