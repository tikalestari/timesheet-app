//
//  EditHoursViewController.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/13/21.
//

import UIKit

class EditHoursViewController: UIViewController {

    @IBOutlet weak var clockInTime: UIDatePicker!
    @IBOutlet weak var clockOutTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // Display updated time
        let homeVc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        homeVc.clockInTimeLabel!.text = "Clocked in at " + Utilities.getTime(clockInTime.date)
        homeVc.clockOutTimeLabel!.text = "Clocked out at " + Utilities.getTime(clockOutTime.date)
        homeVc.clockInTimeLabel!.alpha = 1
        homeVc.clockOutTimeLabel!.alpha = 1
        homeVc.clockInButton!.alpha = 0
        homeVc.clockOutButton!.alpha = 0
        
        // Update document
        homeVc.editWorkHours(clockInTime.date, clockOutTime.date)
        
        navigationController?.pushViewController(homeVc, animated: true)
        dismiss(animated: true, completion: nil)
    }
}
