//
//  Quest.swift
//  C2
//
//  Created by 이은지 on 4/20/26.
//

import SwiftData
import Foundation

@Model
class Quest {
    @Attribute(.unique) var id: UUID
    
    // 기본 정보
    var title: String
    var steps: [String]
    var stepCount: Int {
        steps.count
    }
    var startDate: Date
    
    // 알림 관련
    var isNotificationEnabled: Bool
    var notificationTime: Date?
    var notificationID: String?
    
    
    init(
        id: UUID = UUID(),
        title: String,
        steps: [String] = [],
        startDate: Date = Date(),
        isNotificationEnabled: Bool = false,
        notificationTime: Date? = nil,
        notificationID: String? = nil
    ) {
        self.id = id
        self.title = title
        self.steps = steps
        self.startDate = startDate
        self.isNotificationEnabled = isNotificationEnabled
        self.notificationTime = notificationTime
        self.notificationID = notificationID
    }
}
