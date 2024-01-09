//
//  VC_Extension.swift
//  HallMorgan_CE02-2
//
//  Created by Morgan Hall on 11/29/21.
//

import Foundation
import UIKit

extension ViewController {
    
    //Helper funtion to download and parse data
    
    //Create path to JSON file
    func downloadAndParse(atJson jsonString: String) {
        
        if let path = Bundle.main.path(forResource: jsonString, ofType: ".json"){
            
            //Create URL with newly created path
            let url = URL(fileURLWithPath: path)
            
            //Set up a 'do-catch' block to create a data object and serializze it
            do {
                //Create data object
                let data = try Data.init(contentsOf: url)
                
                //Create a JSON object from the binary data file and cast it as an Any array
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                //Now that we have an array of Any objects that represent our JSON data, parse through the jsonObj and start instantiating
                //Create guard statement to check if json data was created correctly
                guard let json = jsonObj else {
                    print("json was not created correctly")
                    return
                }
                
                //Loop through every first level object
                for firstLevelItem in json {
                    //try to convert the first level item into a [String: Any]
                    guard let object = firstLevelItem as? [String: Any],
                          //Get values for the properties
                          let name = object["employeename"] as? String,
                          let userName = object["username"] as? String,
                          let macAdd = object["macaddress"] as? String,
                          let currentTitle = object["current_title"] as? String,
                          let skills = object["skills"] as? [String]
                    else { continue }
                    
                    var dict = [String: [String]]()
                    
                    guard let pastEmployers = object["past_employers"] as? [[String: Any]]
                    else {
                        continue
                    }
                    //loop through past employers
                    for item in pastEmployers {
                        guard let company = item["company"] as? String,
                              let duties = item["responsibilities"] as? [String]
                        else { return }
                        dict.updateValue(duties, forKey: company)
                    }
                    //Create employee
                    let employee = Employee(name: name, username: userName, macAddress: macAdd, jobTitle: currentTitle, skills: skills, pastEmployers: dict)
                    self.employees.append(employee)
                    
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
            
            //Do UI Stuff
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
}
