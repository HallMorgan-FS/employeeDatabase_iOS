//
//  ViewController.swift
//  HallMorgan_CE02-2
//
//  Created by Morgan Hall on 11/29/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Set outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var macAddressLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalEmployers: UILabel!
    @IBOutlet weak var totalSkills: UILabel!
    
    //Create empty array of employees
    var employees = [Employee]()
    var index = 0
    
    var num = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        downloadAndParse(atJson: "EmployeeData")
        updateLabels()
        
    }
    
    //TableViewDataSource Protocol callbacks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees[index].pastEmployers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Reuse an existing cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse_ID", for: indexPath) as! TableViewCell
        
        if employees[indexPath.row].pastEmployers != nil {
            var dutyList = ""
            // Iterate over the list and set the cell values
            for company in employees[indexPath.row].pastEmployers {
                cell.companyNameLabel.text = company.key
                if company.key == "" {
                    cell.companyNameLabel.text = "No past Employers"
                }
                cell.responsibilityLabel.text = "Responsibilities (\(company.value.count)):"
                for duty in company.value {
                    
                    if duty != company.value.last {
                        dutyList += duty + ", "
                    } else {
                        dutyList += duty
                    }
                }
                
                cell.listedResponsibilities.text = dutyList
                
            }
        }
        else {
            cell.companyNameLabel.text = "No past Employers"
        }
        return cell
        
    }
    
    
    //Set button actions
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        //Make the index counter go down with each tap if index is above 0
        switch index {
        case 1..<employees.count:
            index -= 1
        case employees.startIndex:
            index = employees.index(before: employees.endIndex)
        default:
            print("Index out of range")
        }
        //update lables
        updateLabels()
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Make the index counter go up with each tap unless its the last index
        switch index {
        case 0..<employees.index(before: employees.endIndex)://.endIndex is one greater than the last index. The half open range should check for 0 all the way up to but not including the last index
            //If the index is between 0 and the one before the last index
            index += 1
        case employees.index(before: employees.endIndex):
            //If the index is the last index (one before the end index) then reset the index variable to 0
            index = 0
        default:
            print("Index out of range")
        }
        //update labels
        updateLabels()
        
        
    }
    
    //update labels
    func updateLabels() {
        nameLabel.text = employees[index].name
        userNameLabel.text = employees[index].userName
        macAddressLabel.text = employees[index].macAddress
        jobTitleLabel.text = employees[index].jobTitle
        if employees[index].skills != nil {
            var skillsList = ""
            for skill in employees[index].skills {
                skillsList += skill + ", "
            }
            skillsLabel.text = skillsList
        } else if employees[index].skills.count == 0 {
            skillsLabel.text = "No Skills"
        }
        
        totalEmployers.text = String(employees[index].pastEmployers.count)
        totalSkills.text = String(employees[index].skills.count)
        tableView.reloadData()
        
    }
    

}

