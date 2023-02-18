//
//  DatabaseManager.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 08/12/22.
//

import Foundation
var shareInstance = DatabaseManager()
class DatabaseManager: NSObject{
    
    var database:FMDatabase? = nil
    
    
    class func getInstance() -> DatabaseManager{
        if shareInstance.database == nil{
            shareInstance.database = FMDatabase(path: Utility.getPath("irfan.db"))
        }
        return shareInstance
    }
    
    func handleInsertDeleteUpdate(query: String) -> Bool{
        shareInstance.database?.open()
        let isSave = shareInstance.database?.executeUpdate(query, withArgumentsIn: [])
        shareInstance.database?.close()
        return isSave!
    }
    
    func fetchData(query: String) -> String{
        shareInstance.database?.open()
        var result: String = ""
        do {
            let fmResultSet = try shareInstance.database?.executeQuery(query, values: [Any]())
            while fmResultSet?.next() == true {
                result = fmResultSet?.string(forColumnIndex: 0) ?? ""
            }
        }
        catch {
            print(error.localizedDescription)
        }
        shareInstance.database?.close()
        return result
    }
    
    func fetchDataValue(query: String) -> Double {
        shareInstance.database?.open()
        var result: Double = 0.0
        do {
            let fmResultSet = try shareInstance.database?.executeQuery(query, values: [Any]())
            while fmResultSet?.next() == true {
                result = fmResultSet?.double(forColumnIndex: 0) ?? 0.0
            }
        }
        catch {
            print(error.localizedDescription)
        }
        shareInstance.database?.close()
        return result
    }
    
    class func copyDatabase(_ filename: String){
        
        let dbPath = Utility.getPath("irfan.db")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath){
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(filename)
            var error:NSError?
            do{
                try fileManager.copyItem(atPath: (file?.path)!, toPath: dbPath)
            }catch let error1 as NSError{
                error = error1
            }
            
            if error == nil{
                print("error in db")
            }else{
                print("Yeah !!")
            }
    
        }
    }
}
