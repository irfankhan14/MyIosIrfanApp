//
//  Utility.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 08/12/22.
//

import Foundation

class Utility: NSObject{
    
    class func getPath(_ fileName: String) -> String{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        print("Database Path :- \(fileUrl.path)")
        return fileUrl.path
    }
    
}

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func capitalizingEveryFirstLetterInSentence(data: String) -> String {
        let breakupSentence = data.components(separatedBy: " ")
        var newSentence = ""
        
        for wordInSentence  in breakupSentence {
            newSentence = "\(newSentence)\(wordInSentence.capitalizingFirstLetter()) "
        }
        newSentence = newSentence.removeLastCharacterInString(data: newSentence)
        return newSentence
    }
    
    mutating private func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func removeLastCharacterInString(data: String) -> String {
        if (data == "") {
            return data
        } else {
            return data.substring(to: data.index(before: data.endIndex))
        }
    }

}
