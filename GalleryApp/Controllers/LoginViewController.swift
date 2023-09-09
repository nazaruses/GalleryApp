//
//  LoginViewController.swift
//  GalleryApp
//
//  Created by Nazar Dremach on 20/8/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var numButtons: [UIButton]!
    
    @IBOutlet weak var faceIdButton: UIButton!
    
    @IBOutlet weak var backspaceButton: UIButton!
    
    @IBOutlet weak var passField: UILabel!
    
    
    var enteredPass = "" { didSet {
        updatePassField()
        
    }
    }
    let requiredPass = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatePassField()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        enteredPass = ""
    }
    
    private func updatePassField() {
        guard enteredPass.count > 0 else {
            passField.text = "Enter Password"
            return
        }
        
        passField.text = enteredPass.getConfidentString()
        
        if enteredPass == requiredPass {
        confirmPass()
    }
    }
    
    func confirmPass() {
        let destinationController = GalleryViewController()
            destinationController.modalPresentationStyle = .fullScreen
            self.present(destinationController, animated: false)
    }
    
    @IBAction func enterNum(_ sender: UIButton) {
        enteredPass.append("\(sender.tag)")
    }
    
    @IBAction func enterByFaceid(_ sender: Any) {
        confirmPass()
    }
    
    @IBAction func deleteSymbol(_ sender: Any) {
        enteredPass.deleteLastSymbol()
    }
    
}
