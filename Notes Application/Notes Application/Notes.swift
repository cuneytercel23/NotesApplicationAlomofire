//
//  Notes.swift
//  Notes Application
//
//  Created by Cüneyt Erçel on 6.09.2022.
//

import Foundation

class Notes : Codable {
    
   var not_id : String?
   var ders_adi : String?
    var note1 : String?
    var note2 : String?
    
    init() {
        
    }
    
    init(not_id : String, ders_adi : String, note1 : String,note2 : String ) {
        
        self.not_id = not_id
        self.ders_adi = ders_adi
        self.note1 = note1
        self.note2 = note2
    }
}
