//
//  HomeViewController.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/7/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var clockInButton: UIButton!
    @IBOutlet weak var clockOutButton: UIButton!
    @IBOutlet weak var clockInTimeLabel: UILabel!
    @IBOutlet weak var clockOutTimeLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func setUpElements() {
        
        // Display Custom welcome label OR the current date? (eventually both in the future)
//        let user = getCurrentUser()
//        welcomeLabel.text = "Welcome, " + user?.displayName + "."
        welcomeLabel.text = Utilities.getDate(Date())
        
        // Hide clock in/out time
        clockInTimeLabel.alpha = 0
        clockOutTimeLabel.alpha = 0
        
        // Filled rounded corner style
        clockInButton.backgroundColor = UIColor.init(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
        clockInButton.layer.cornerRadius = 25.0
        clockInButton.tintColor = UIColor.white
        
        // Filled rounded corner style
        clockOutButton.backgroundColor = UIColor.init(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        clockOutButton.layer.cornerRadius = 25.0
        clockOutButton.tintColor = UIColor.white
    }
    
    @IBAction func clockInTapped(_ sender: Any) {
        let user = getCurrentUser()
        let date = Date()
        var ref: DocumentReference? = nil
        ref = db.collection("hoursLogged").addDocument(data: [
            "uid": user!.uid,
            "clockIn": Utilities.getDateTime(date)
        ]) { err in
            if let err = err {
                print("Error adding clockIn log entry: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        clockInButton.alpha = 0
        clockInTimeLabel.text = "Clocked in at " + Utilities.getTime(date)
        clockInTimeLabel.alpha = 1
    }
    
    @IBAction func clockOutTapped(_ sender: Any) {
        let user = getCurrentUser()
        let date = Date()
        var ref: DocumentReference? = nil
        ref = db.collection("hoursLogged").addDocument(data: [
            "uid": user!.uid,
            "clockOut": Utilities.getDateTime(date)
        ]) { err in
            if let err = err {
                print("Error adding clockOut log entry: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        clockOutButton.alpha = 0
        clockOutTimeLabel.text = "Clocked out at " + Utilities.getTime(date)
        clockOutTimeLabel.alpha = 1
    }
    
    private func getCurrentUser() -> User? {
        let user = Auth.auth().currentUser
        if (user != nil) {
            return user!
        } else {
            print("User not logged in")
            // TODO: alert or warning here
            return nil
        }
    }
}
