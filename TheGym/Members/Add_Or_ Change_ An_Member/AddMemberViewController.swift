//
//  AddMemberViewController.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-22.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {
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
    
    var members = [Member]()
    var member: Member?
    var memberId: String?
    var changeMemberInfo: Bool?
    var addMember: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.writeMemberToTextFields(member: self.member ?? Member(json: ["name" : "No name"]))
            self.choosenAddOrPutMember(add: self.addMember ?? false, put: self.changeMemberInfo ?? false)
        }
    }
    
    func postNewMember() {
        let parameters = ["userName" : userNameTextField.text ?? "", "firstName" : firstNameTextField.text ?? "", "lastName" : lasNameTextField.text ?? "", "adress" : adressTextField.text ?? "", "phoneNumber" : phonenumberTextField.text ?? "", "mail" : mailTextField.text ?? "", "id" : idTextField.text ?? "", "memberShipLevel" : ["gold" : true, "silver" : false, "bronze" : false]] as [String : Any]
        
        guard let memberUrl = URL(string: "http://localhost:8080/gym/members") else { return }
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
    
    func putMember(id: String) {
        let parameters = ["userName" : userNameTextField.text ?? "", "firstName" : firstNameTextField.text ?? "", "lastName" : lasNameTextField.text ?? "", "adress" : adressTextField.text ?? "", "phoneNumber" : phonenumberTextField.text ?? "", "mail" : mailTextField.text ?? "", "id" : idTextField.text ?? "", "memberShipLevel" : ["gold" : true, "silver" : false, "bronze" : false]] as [String : Any]
        
        guard let memberUrl = URL(string: "http://localhost:8080/gym/members/\(id)") else { return }
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
    
    func deleteMember(id: String) {
        let parameters = ["userName" : userNameTextField.text ?? "", "firstName" : firstNameTextField.text ?? "", "lastName" : lasNameTextField.text ?? "", "adress" : adressTextField.text ?? "", "phoneNumber" : phonenumberTextField.text ?? "", "mail" : mailTextField.text ?? "", "id" : idTextField.text ?? "", "memberShipLevel" : ["gold" : true, "silver" : false, "bronze" : false]] as [String : Any]
        
        guard let memberUrl = URL(string: "http://localhost:8080/gym/members/\(id)") else { return }
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
    
    func choosenAddOrPutMember(add: Bool, put: Bool) {
        if add == true {
            navigationBar.topItem?.title = "Add new member"
            putButton.isHidden = true
            deleteItemButton.isEnabled = false
        }
        else if put == true {
            navigationBar.topItem?.title = "Change member"
            addButton.isHidden = true
            self.writeMemberToTextFields(member: self.member ?? Member(json: ["name" : "No name"]))
        }
    }
    
    func writeMemberToTextFields(member: Member) {
        userNameTextField.text = member.userName ?? "uN"
        firstNameTextField.text = member.firstName ?? "fN"
        lasNameTextField.text = member.lastName ?? "lN"
        adressTextField.text = member.adress ?? "a"
        phonenumberTextField.text = member.phoneNumber ?? "pN"
        mailTextField.text = member.mail ?? "m"
        idTextField.text = member.id ?? "id"
    }
    
    @IBAction func addMemberButton(_ sender: UIButton) {
        postNewMember()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func putMemberButton(_ sender: UIButton) {
        putMember(id: member?.id ?? "-0")
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteItemButton(_ sender: Any) {
        deleteMember(id: String(member?.id ?? "-0"))
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
