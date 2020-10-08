//
//  APiMethods.swift
//  LearningOne
//
//  Created by Ashish Pandey on 14/09/20.
//  Copyright © 2020 Simmy Pandey. All rights reserved.
//

import UIKit
import Alamofire


class APIMethodCall {
    
    var vc : ViewController?
    var userArray = [UserModal]()
    
      func callUserAPI() {
         
        let url = URL(string: APICall.COUNTRYURL)
        Alamofire.request(url!, method: .get).responseJSON { (response) in
            
            print(response)
         
            if let data = response.data {
                
                print(data)
                           
                    do {
                        let decodeData = try JSONDecoder().decode([UserModal].self, from: data)
                        print(decodeData)
                        self.userArray.append(contentsOf: decodeData)
                        self.vc?.tblviewUser.reloadData()
                        } catch let err{
                            print(err.localizedDescription)
                        }
                   }
            }
        }
}




