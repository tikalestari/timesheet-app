//
//  EditHoursViewController.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/13/21.
//

import UIKit

protocol TaskDelegate {
    func updateHours(_ clockIn: Date, _ clockOut: Date)
}

class EditHoursViewController: UIViewController {

    @IBOutlet weak var clockInTime: UIDatePicker!
    @IBOutlet weak var clockOutTime: UIDatePicker!
    
    var delegate: TaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        delegate?.updateHours(clockInTime.date, clockOutTime.date)
        dismiss(animated: true, completion: nil)
    }
}
