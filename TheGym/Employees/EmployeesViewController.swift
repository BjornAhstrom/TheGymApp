//
//  EmployeesViewController.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-22.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var employeesTableView: UITableView!
    
    private var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.employeesTableView.delegate = self
        self.employeesTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEmployeeApi()
    }
    
    func getEmployeeApi() {
        employees = []
        guard let employeeApi = URL(string: "http://localhost:8080/gym/employees") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: employeeApi) { (data, response, error) in
            if let response = response {
                print("Response \(response)")
            }
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else { return }
                    for employees in json {
                        
                        let emp = Employee(json: employees)
                        print("!!!!!!!! \(emp.firstName ?? "")")
                        
                        self.employees.append(emp)
                        
                        DispatchQueue.main.async {
                            self.employeesTableView.reloadData()
                        }
                    }
                    
                } catch {
                    print("Something went wrong, message: \(error.localizedDescription )")
                }
            }
        }.resume()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emloyeeCell", for: indexPath) as? EmployeeTableViewCell
        let emp = employees[indexPath.row]
        
        cell?.userNameLabel.text = "\(emp.userName ?? "")"
        cell?.firstNameLabel.text = "\(emp.firstName ?? "")"
        cell?.lastNameLabel.text = "\(emp.lastName ?? "")"
        cell?.adressLabel.text = "\(emp.adress ?? "")"
        cell?.phoneNumberLabel.text = "\(emp.phoneNumber ?? "")"
        cell?.mailLabel.text = "\(emp.mail ?? "")"
        cell?.idLabel.text = "Id \(emp.id ?? "")"
        
        return cell ?? cell!
    }
}
