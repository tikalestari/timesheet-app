//
//  HoursLog.swift
//  timesheetapp
//
//  Created by Tika Lestari on 2/11/21.
//

import Foundation
import FirebaseFirestoreSwift

struct HoursLog: Identifiable, Codable {
    @DocumentID var id: String?
    var clockIn: String
    var clockOut: String
    
    enum CodingKeys: String, CodingKey {
        case clockIn
        case clockOut
    }
}
