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
    @IBOutlet weak var changeEmployeeInfoButton: UIButton!
    
    private var employees = [Employee]()
    var employee: Employee?
    
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
                        
                        self.employees.append(emp)
                        
                        DispatchQueue.main.async {
                            self.employeesTableView.reloadData()
                        }
                    }
                    
                } catch {
                    print(error.localizedDescription)
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
        cell?.idLabel.text = "\(emp.id ?? "")"
        
        return cell ?? cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let employeeCell = tableView.cellForRow(at: indexPath) as? EmployeeTableViewCell else { return }
        
        let parameters = ["userName" : employeeCell.userNameLabel.text, "firstName" : employeeCell.firstNameLabel.text, "lastName" : employeeCell.lastNameLabel.text, "adress" : employeeCell.adressLabel.text, "phoneNumber" : employeeCell.phoneNumberLabel.text, "mail" : employeeCell.mailLabel.text, "id" : employeeCell.idLabel.text]
        
        employee = Employee(json: parameters as [String : Any])
        
        performSegue(withIdentifier: "changeEmployeeInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.async {
            if segue.identifier == "changeEmployeeInfo" {
                if let destination = segue.destination as? AddOrChangeAnEmployeeViewController {
                    destination.changeEmployeeInfo = true
                    destination.employee = self.employee
                }
            }
        }
        
        if segue.identifier == "addEmployeeSegue" {
            if let destination = segue.destination as? AddOrChangeAnEmployeeViewController {
                destination.addEmployee = true
            }
        }
    }
}
