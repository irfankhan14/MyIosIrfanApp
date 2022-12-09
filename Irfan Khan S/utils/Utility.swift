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
