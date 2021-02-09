//
//  HomeViewController.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/7/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var clockInButton: UIButton!
    @IBOutlet weak var clockOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
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
        // TODO: enter clock-in time in db
    }
    
    @IBAction func clockOutTapped(_ sender: Any) {
        // TODO: enter clock-out time in db
    }
    
}
