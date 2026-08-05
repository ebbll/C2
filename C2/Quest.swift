//
//  Quest.swift
//  C2
//
//  Created by 이은지 on 4/20/26.
//

import SwiftData
import Foundation

@Model
class QuestStep {
    var id: UUID = UUID()
    var content: String
    var isCompleted: Bool = false
    var order: Int
    
    init(
        id: UUID =  UUID(),
        content: String,
        isCompleted: Bool = false,
        order: Int
    ) {
        self.id = id
        self.content = content
        self.isCompleted = isCompleted
        self.order = order
    }
}

enum QuestCategory: String, Codable, CaseIterable {
    case all = "전체"
    case academy = "아카데미 튜토리얼"
    case postech = "포스텍 시설 정복"
    case tool = "학생 계정 툴 신청"
}

@Model
class Quest {
    // 기본 정보
    var id: UUID
    var title: String

    // 하위 할 일
    var steps: [QuestStep]
    
    // 정렬된 하위 할 일
    var sortedSteps: [QuestStep] {
        steps.sorted(by: { $0.order < $1.order })
    }

    var isCompleted: Bool

    // 추천 시작일
    var recommendedDate: Date?
    
    // 실제 수행한 기간
    var startDate: Date? = nil
    var endDate: Date? = nil
    
    // 카테고리
    var category: QuestCategory = QuestCategory.all
    
    // 알림 관련
    var isNotificationEnabled: Bool
    var notificationID: String?
    var notificationTime: Date?
    
    init(
        id: UUID = UUID(),
        title: String,
        steps: [QuestStep] = [],
        isCompleted: Bool = false,
        recommendedDate: Date,
        startDate: Date? = nil,
        endDate: Date? = nil,
        category: QuestCategory = .all,
        isNotificationEnabled: Bool = false,
        notificationID: String? = nil,
        notificationTime: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.steps = steps.sorted { $0.order < $1.order }
        self.isCompleted = isCompleted
        self.recommendedDate = recommendedDate
        self.startDate = startDate
        self.endDate = endDate
        self.category = category
        self.isNotificationEnabled = isNotificationEnabled
        self.notificationTime = notificationTime
        self.notificationID = notificationID
    }
    
    // 특정 퀘스트 완료 처리
    func toggleStepCompletion(at index: Int) {
        let sorted = sortedSteps
        if index >= 0 && index < sorted.count {
            sorted[index].isCompleted.toggle()
        }
    }
    
    // 현재 진행 가능한 step의 index 계산
    func availableSteps() -> Int {
        let sorted = sortedSteps
        for index in 0..<sorted.count {
            if sorted[index].isCompleted == true {
                continue
            }
            return sorted[index].order
        }
        // 모든 스텝이 완료된 경우
        return -1
    }
}
