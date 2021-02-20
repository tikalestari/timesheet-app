//
//  LoginViewController.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/7/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Validate Text Fields
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                self.transitionToHome()
            }
        }
    }
    
    func transitionToHome() {
        let tabBarVC = UITabBarController()
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        let summaryViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.summaryViewController) as? SummaryViewController
        
        let vc1 = UINavigationController(rootViewController: homeViewController!)
        let vc2 = UINavigationController(rootViewController: summaryViewController!)
        
        vc1.title = "Home"
        vc2.title = "Summary"
        
        tabBarVC.setViewControllers([vc1, vc2], animated: false)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["house", "star"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
