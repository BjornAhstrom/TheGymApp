//
//  MemberViewController.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-22.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var memberTableView: UITableView!
    
    private var members = [Membership]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memberTableView.delegate = self
        self.memberTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEmployeeApi()
    }
    
    func getEmployeeApi() {
        members = []
        guard let employeeApi = URL(string: "http://localhost:8080/gym/members") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: employeeApi) { (data, response, error) in
            if let response = response {
                print("Response \(response)")
            }
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else { return }
                    
                    for members in json {
                        guard let membershipLevel = members["memberShipLevel"] as? [String : Any] else { return }
                        
                        let mem = Membership(member: Member(json: members), membershipLevel: MembershipLevel(json: membershipLevel))
                        
                        self.members.append(mem)
                        
                        DispatchQueue.main.async {
                            self.memberTableView.reloadData()
                        }
                    }
                    
                } catch {
                    print("Something went wrong, message: \(error.localizedDescription )")
                }
            }
            }.resume()
        
    }
    
    func membershipLevel(level: Bool) -> Bool {
        
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("!!!!!!!!!!!!!!!!!!! \(members.count)")
        return members.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as? MemberTableViewCell
        let mem = members[indexPath.row]
        
        cell?.userNameLabel.text = "\(mem.member.userName ?? "userName")"
        cell?.firstNameLabel.text = "\(mem.member.firstName ?? "firstName")"
        cell?.lastNameLabel.text = "\(mem.member.lastName ?? "lastName")"
        cell?.adressLabel.text = "\(mem.member.adress ?? "adress")"
        cell?.phoneNumberLabel.text = "\(mem.member.phoneNumber ?? "phoneNumber")"
        cell?.mailLabel.text = "\(mem.member.mail ?? "mail")"
        cell?.idLabel.text = "Id \(mem.member.id ?? "id")"
        
        
        return cell ?? cell!
    }
}
