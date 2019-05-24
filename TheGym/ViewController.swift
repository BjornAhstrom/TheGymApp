//
//  ViewController.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-22.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var logoTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var openTextLabel: UILabel!
    @IBOutlet weak var closingTextLabel: UILabel!
    @IBOutlet weak var openTimeTextField: UITextField!
    @IBOutlet weak var closingTimeTextField: UITextField!
    @IBOutlet weak var editItemButton: UIBarButtonItem!
    @IBOutlet var buttons: [UIButton]!
    
    var edit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editingTextFields(edit: edit)
        setBorderRadiusOnButtonsAndLabels()
    }
    
    func editingTextFields(edit: Bool) {
        logoTextField.isEnabled = edit
        adressTextField.isEnabled = edit
        phoneNumberTextField.isEnabled = edit
        mailTextField.isEnabled = edit
        openTimeTextField.isEnabled = edit
        closingTimeTextField.isEnabled = edit
    }
    
    @IBAction func editItemButton(_ sender: UIBarButtonItem) {
        self.setEditing(!self.isEditing, animated: true)
        let newButton = UIBarButtonItem(barButtonSystemItem: (self.isEditing) ? .done : .edit, target: self, action: #selector(editItemButton(_:)))
        self.navigationItem.setRightBarButton(newButton, animated: true)
        editingTextFields(edit: (self.isEditing) ? true : false)
    }
    
    func setBorderRadiusOnButtonsAndLabels() {
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 15
            
        }
    }
}

