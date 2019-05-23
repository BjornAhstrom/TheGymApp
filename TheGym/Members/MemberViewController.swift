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
    var member: Member?
    
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
        cell?.idLabel.text = "\(mem.member.id ?? "id")"
        
        return cell ?? cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let employeeCell = tableView.cellForRow(at: indexPath) as? MemberTableViewCell else { return }
        
        let parameters = ["userName" : employeeCell.userNameLabel.text, "firstName" : employeeCell.firstNameLabel.text, "lastName" : employeeCell.lastNameLabel.text, "adress" : employeeCell.adressLabel.text, "phoneNumber" : employeeCell.phoneNumberLabel.text, "mail" : employeeCell.mailLabel.text, "id" : employeeCell.idLabel.text]
        
        member = Member(json: parameters as [String : Any])
        
        performSegue(withIdentifier: "changeMemberInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.async {
            if segue.identifier == "changeMemberInfo" {
                if let destination = segue.destination as? AddMemberViewController {
                    destination.changeMemberInfo = true
                    destination.member = self.member
                }
            }
        }
        
        if segue.identifier == "addMemberSegue" {
            if let destination = segue.destination as? AddMemberViewController {
                destination.addMember = true
            }
        }
    }
}
