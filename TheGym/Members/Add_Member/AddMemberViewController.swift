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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func postNewMember() {
        let parameters = ["userName" : userNameTextField.text, "firstName" : firstNameTextField.text, "lastName" : lasNameTextField.text, "adress" : adressTextField.text, "phoneNumber" : phonenumberTextField.text, "mail" : mailTextField.text, "id" : idTextField.text, "memberShipLevel" : ["gold" : true, "silver" : false, "bronze" : false]] as [String : Any]
        
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
    
    @IBAction func addMemberButton(_ sender: UIButton) {
        postNewMember()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
