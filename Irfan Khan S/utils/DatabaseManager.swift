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
    

    
    
    func fetchData() -> Bool{
        shareInstance.database?.open()
        
        var vds = [Any]()
        let querySQL = "SELECT * FROM accounts"
        
        do {
            let results = try shareInstance.database?.executeQuery(querySQL, values: vds)
            
            while results?.next() == true {
                var reason = results?.string(forColumn: "reason")
                var amount = results?.string(forColumn: "amount")
                var result = "Account::" + reason! + ", Rs." + amount!
                print( result)
                
            }
        }
        catch {
            print(error.localizedDescription)
        }
        shareInstance.database?.close()
        return true
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
