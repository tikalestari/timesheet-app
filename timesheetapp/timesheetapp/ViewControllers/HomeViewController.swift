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
        let currentDateTime = Utilities.getDateTime()
        var ref: DocumentReference? = nil
        ref = db.collection("hoursLogged").addDocument(data: [
            "uid": user!.uid,
            "clockIn": currentDateTime
        ]) { err in
            if let err = err {
                print("Error adding clockIn log entry: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    @IBAction func clockOutTapped(_ sender: Any) {
        let user = getCurrentUser()
        let currentDateTime = Utilities.getDateTime()
        var ref: DocumentReference? = nil
        ref = db.collection("hoursLogged").addDocument(data: [
            "uid": user!.uid,
            "clockOut": currentDateTime
        ]) { err in
            if let err = err {
                print("Error adding clockOut log entry: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
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
