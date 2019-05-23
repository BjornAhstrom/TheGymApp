//
//  AddEmployeeViewController.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-23.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit

class AddOrChangeAnEmployeeViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lasNameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var putButton: UIButton!
    @IBOutlet weak var deleteItemButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var employees = [Employee]()
    var employee: Employee?
    var employeeId: String?
    var changeEmployeeInfo: Bool?
    var addEmployee: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.writeEmployeeToTextFields(employee: self.employee ?? Employee(json: ["name" : "No name"]))
            self.choosenAddOrPutEmployee(add: self.addEmployee ?? false, put: self.changeEmployeeInfo ?? false)
        }
    }
    
    func postNewEmployee() {
        let parameters: [String : Any] = ["userName" : userNameTextField.text ?? "", "firstName" : firstNameTextField.text ?? "", "lastName" : lasNameTextField.text ?? "", "adress" : adressTextField.text ?? "", "phoneNumber" : phonenumberTextField.text ?? "", "mail" : mailTextField.text ?? "", "id" : idTextField.text ?? ""]
        
        guard let memberUrl = URL(string: "http://localhost:8080/gym/employees") else { return }
        var request = URLRequest(url: memberUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    func putEmployee(id: String) {
        let parameters: [String : Any] = ["userName" : userNameTextField.text ?? "", "firstName" : firstNameTextField.text ?? "", "lastName" : lasNameTextField.text ?? "", "adress" : adressTextField.text ?? "", "phoneNumber" : phonenumberTextField.text ?? "", "mail" : mailTextField.text ?? "", "id" : idTextField.text ?? ""]
        
        guard let memberUrl = URL(string: "http://localhost:8080/gym/employees/\(id)") else { return }
        var request = URLRequest(url: memberUrl)
        request.httpMethod = "PUT"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    func deleteEmployee(id: String) {
        let parameters: [String : Any] = ["userName" : userNameTextField.text ?? "", "firstName" : firstNameTextField.text ?? "", "lastName" : lasNameTextField.text ?? "", "adress" : adressTextField.text ?? "", "phoneNumber" : phonenumberTextField.text ?? "", "mail" : mailTextField.text ?? "", "id" : idTextField.text ?? ""]
        
        guard let memberUrl = URL(string: "http://localhost:8080/gym/employees/\(id)") else { return }
        var request = URLRequest(url: memberUrl)
        request.httpMethod = "DELETE"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    func choosenAddOrPutEmployee(add: Bool, put: Bool) {
        if add == true {
            navigationBar.topItem?.title = "Add new employee"
            putButton.isHidden = true
            deleteItemButton.isEnabled = false
        }
        else if put == true {
            navigationBar.topItem?.title = "Change employee"
            addButton.isHidden = true
            self.writeEmployeeToTextFields(employee: self.employee ?? Employee(json: ["name" : "No name"]))
        }
    }
    
    func writeEmployeeToTextFields(employee: Employee) {
        userNameTextField.text = employee.userName ?? "uN"
        firstNameTextField.text = employee.firstName ?? "fN"
        lasNameTextField.text = employee.lastName ?? "lN"
        adressTextField.text = employee.adress ?? "a"
        phonenumberTextField.text = employee.phoneNumber ?? "pN"
        mailTextField.text = employee.mail ?? "m"
        idTextField.text = employee.id ?? "id"
    }
    
    @IBAction func addEmployeeButton(_ sender: UIButton) {
        postNewEmployee()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func putEmployeButton(_ sender: UIButton) {
        putEmployee(id: employee?.id ?? "-0")
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteItemButton(_ sender: Any) {
        deleteEmployee(id: String(employee?.id ?? "-0"))
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelItemButton(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
