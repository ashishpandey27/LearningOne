//
//  ViewController.swift
//  LearningOne
//
//  Created by Ashish Pandey on 10/09/20.
//  Copyright © 2020 Simmy Pandey. All rights reserved.
//

import UIKit

struct Country : Codable {
    
    let name : String
    let capital : String
    let region : String
     
}

class ViewController: UIViewController {

    @IBOutlet weak var tblviewUser: UITableView!
    
    var userModel = APIMethodCall()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userModel.vc = self
        userModel.callUserAPI()
        
        
        
        print("wefbjhwebfuyewfujwe ewjgfyuewgfjew fyewhfyewgyfgewyf weyf ywegfywegf")
    
    }
    
  
}







extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return userModel.userArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblviewUser.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath) as! UserCell
        
        cell.id.text = (userModel.userArray[indexPath.row].title)
        cell.body.text = userModel.userArray[indexPath.row].description
        
        
        return cell
    }
}

class UserCell : UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var body: UILabel!
    
}





/*


 let url = "https://restcountries.eu/rest/v2/all"
 let urlObj = URL(string: url)
 
 URLSession.shared.dataTask(with: urlObj!) { (data, response, error) in
     
     do {
         
         var countries = try JSONDecoder().decode([Country].self, from: data!)
         
      
         
         for country in countries {

             print(country.name + " : " + country.capital +  " -> " + country.region)
         }
         
         
     } catch {
         print("We got an error")
         
     }
 }.resume()

*/
