//
//  LoginViewController.swift
//  GalleryApp
//
//  Created by Nazar Dremach on 20/8/23.
//

import UIKit
import LocalAuthentication


class LoginViewController: UIViewController {

    @IBOutlet var numButtons: [UIButton]!
    
    @IBOutlet weak var faceIdButton: UIButton!
    
    @IBOutlet weak var backspaceButton: UIButton!
    
    @IBOutlet weak var passField: UILabel!
    
    
    var enteredPass = "" { didSet { updatePassField() } }
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
    
    private func confirmPass() {
        let destinationController = GalleryViewController()
        destinationController.modalPresentationStyle = .fullScreen
        self.present(destinationController, animated: false)
    }
    
    private func authenticateFaceId() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "А это точно ты?!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async { [weak self] in
                    
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Some shit happened", message: error?.description, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(action)
                        self?.present(alert, animated: true)
                        return
                    }
                    
                    self?.confirmPass()
                }
            }
        } else {
            let alert = UIAlertController(title: "Unavailable", message: "FaceID Auth not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    @IBAction func enterNum(_ sender: UIButton) {
        enteredPass.append("\(sender.tag)")
    }
    
    @IBAction func enterByFaceid(_ sender: Any) {
        authenticateFaceId()
    }
    
    @IBAction func deleteSymbol(_ sender: Any) {
        enteredPass.deleteLastSymbol()
    }
    
}
