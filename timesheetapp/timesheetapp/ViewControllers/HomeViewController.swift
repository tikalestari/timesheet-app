//
//  HomeViewController.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/7/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var clockInButton: UIButton!
    @IBOutlet weak var clockOutButton: UIButton!
    @IBOutlet weak var clockInTimeLabel: UILabel!
    @IBOutlet weak var clockOutTimeLabel: UILabel!
    @IBOutlet weak var totalHoursWorkedLabel: UILabel!
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
        totalHoursWorkedLabel.alpha = 0
        
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
        let userUid = user!.uid
        let date = Date()
        
        db.collection("hoursLogged").document(userUid).setData([
            "uid": userUid,
            "clockIn": Utilities.getISODateFromDate(date)
        ], merge: true) { err in
            if let err = err {
                print("Error writing document for uid \(userUid): \(err)")
            } else {
                print("Document successfully written for uid \(userUid)")
            }
        }
        
        clockInButton.alpha = 0
        clockInTimeLabel.text = "Clocked in at " + Utilities.getTime(date)
        clockInTimeLabel.alpha = 1
    }
    
    @IBAction func clockOutTapped(_ sender: Any) {
        let user = getCurrentUser()
        let date = Date()
        let userUid = user!.uid
        
        db.collection("hoursLogged").document(userUid).setData([
            "uid": userUid,
            "clockOut": Utilities.getISODateFromDate(date)
        ], merge: true) { err in
            if let err = err {
                print("Error writing document for uid \(userUid): \(err)")
            } else {
                print("Document successfully written for uid \(userUid)")
            }
        }
        
        clockOutButton.alpha = 0
        clockOutTimeLabel.text = "Clocked out at " + Utilities.getTime(date)
        clockOutTimeLabel.alpha = 1
        displayTotalHours(user!)
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
    
    private func displayTotalHours(_ user: User) {

        // Get clockIn and clockOut data from firestore
        let user = getCurrentUser()
        let userUid = user!.uid
        
        db.collection("hoursLogged").document(userUid).getDocument { (document, err) in
            if let document = document, document.exists {
                let clockIn = document.data()!["clockIn"] as? String ?? ""
                let clockOut = document.data()!["clockOut"] as? String ?? ""
                let clockInDate = Utilities.getISODateFromString(clockIn)
                let clockOutDate = Utilities.getISODateFromString(clockOut)
                let totalSecondsWorked = clockOutDate.timeIntervalSince(clockInDate)
                self.displayTotalHours(totalSecondsWorked)
            } else {
                print("Document does not exist")
            }
        }
    }
    private func displayTotalHours(_ interval: TimeInterval) {
        let interval = Int(interval)
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        let output = String(format: "%02d hours and %02d minutes", hours, minutes)
        totalHoursWorkedLabel.text = "You've worked " + output + " today."
        totalHoursWorkedLabel.alpha = 1
    }
}
