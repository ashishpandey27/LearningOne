//
//  ViewControllerOne.swift
//  LearningOne
//
//  Created by Ashish Pandey on 14/09/20.
//  Copyright © 2020 Simmy Pandey. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerOne: UIViewController {

    @IBOutlet weak var txtfieldHero: UITextField!
    @IBOutlet weak var txtfieldPowerRanking: UITextField!
    @IBOutlet weak var tblViewHeroes: UITableView!
    
    var db : OpaquePointer?
    var heroList = [Hero]()
    var api = APIMethodCall()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Creating the databse
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("HeoresDatabase.sqlite")

        //Opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
               print("Error is found")
        }
        // Create the table
          
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heores ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error msg \(errmsg)")
        }
        
        print("Everything is fine")
        
           readValues()
        api.callUserAPI()
        
    }
    
    @IBAction func btn_click_save(_ sender: UIButton) {
        
        let name = txtfieldHero.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let powerRANKING = txtfieldPowerRanking.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //validating that values are not empty
               if(name?.isEmpty)!{
                   txtfieldHero.layer.borderColor = UIColor.red.cgColor
                   return
               }
        
               if(powerRANKING?.isEmpty)!{
                   txtfieldPowerRanking.layer.borderColor = UIColor.red.cgColor
                   return
               }
        
        var stmt : OpaquePointer?
        
        let insertQuery = "INSERT INTO Heores (name, powerrank) VALUES (?, ?)"
        
        if sqlite3_prepare(db,  insertQuery, -1 , &stmt, nil) != SQLITE_OK {
            
            print("Error binding query")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK {
             print("Error binding name")
            return
        }
        
        if sqlite3_bind_int(stmt, 2, (powerRANKING! as NSString).intValue) != SQLITE_OK {
            print("Error binding powerrank")
            return
        }
        
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            
            print("Hero saved successfully.")
            
            txtfieldHero.text=""
            txtfieldPowerRanking.text=""
            
            readValues()
            
        }
        
        
        
    }
    
    
    func readValues() {
        
         //first empty the list of heroes
        heroList.removeAll()
        
        //this is our select query
        let queryString = "SELECT * from Heores"
        
        //statement pointer
        var stmt:OpaquePointer?
        
           //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing insert: \(errmsg)")
            return
        }
        
         //traversing through all the records
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let powerrank = sqlite3_column_int(stmt, 2)
            
            heroList.append(Hero(id: Int(id), name: name, powerRanking: Int(powerrank)))
        }
        
        self.tblViewHeroes.reloadData()
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ViewControllerOne : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return heroList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblViewHeroes.dequeueReusableCell(withIdentifier: "cellHero", for: indexPath) as! HeroCell
        
        let hero: Hero
        hero = heroList[indexPath.row]
        
        cell.nameHero.text = hero.name
        
        
        return cell
    }
}

class HeroCell : UITableViewCell {
    
   
    @IBOutlet weak var nameHero: UILabel!
    
    
}
