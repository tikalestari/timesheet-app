//
//  AlwaysPresentAsPopover.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/14/21.
//

import Foundation
import UIKit

// By default, when you use:
//    controller.modalPresentationStyle = .popover
// in a horizontally compact environment (iPhone in portrait mode),
// this option behaves the same as fullScreen.
// You can make it to always show a popover by using:
//    let presentationController =
//       AlwaysPresentAsPopover.configurePresentation(forController:
//                                                controller)

class AlwaysPresentAsPopover: NSObject, UIPopoverPresentationControllerDelegate {
    // `sharedInstance` because the delegate property is weak - the delegate instance needs to be retained.
    private static let sharedInstance = AlwaysPresentAsPopover()
    
    private override init() {
        super.init()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    static func configurePresentation(forController controller : UIViewController) -> UIPopoverPresentationController {
        controller.modalPresentationStyle = .popover
        let presentationController = controller.presentationController as! UIPopoverPresentationController
        presentationController.delegate = AlwaysPresentAsPopover.sharedInstance
        return presentationController
    }
}


