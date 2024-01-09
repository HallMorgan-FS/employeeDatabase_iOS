//
//  Employee.swift
//  HallMorgan_CE02-2
//
//  Created by Morgan Hall on 11/29/21.
//

import Foundation

class Employee {
    
    /* Stored Properties */
    var name: String
    var userName: String
    var macAddress: String
    var jobTitle: String
    var skills: [String]!
    var pastEmployers: [String: [String]]!
   
    
    
    /* initializers */
    init(name: String, userName: String, macAddress: String, jobTitle: String, skills: [String]!, pastEmployers: [String: [String]]!) {
        self.name = name
        self.userName = userName
        self.macAddress = macAddress
        self.jobTitle = jobTitle
        self.skills = skills
        self.pastEmployers = pastEmployers
    }
    
    convenience init(name: String, username: String, macAddress: String, jobTitle: String, skills: [String]? = nil, pastEmployers: [String: [String]]? = nil) {
        
        //Check if skills, companies, or responsibilities are nil
        if skills == nil {
            self.init(name: name, userName: username, macAddress: macAddress, jobTitle: jobTitle, skills: nil, pastEmployers: pastEmployers)
        }
        else if pastEmployers == nil {
            self.init(name: name, userName: username, macAddress: macAddress, jobTitle: jobTitle, skills: skills, pastEmployers: nil)
        }
        else {
            self.init(name: name, userName: username, macAddress: macAddress, jobTitle: jobTitle, skills: skills, pastEmployers: pastEmployers)
        }
        
        
    }
    
    
}
