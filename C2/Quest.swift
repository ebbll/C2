//
//  Quest.swift
//  C2
//
//  Created by 이은지 on 4/20/26.
//

import SwiftData
import Foundation

struct QuestStep: Codable, Identifiable {
    var id: UUID = UUID()
    var content: String
    var isCompleted: Bool = false
    var order: Int
}

enum QuestCategory: String, Codable, CaseIterable {
    case academy = "아카데미 튜토리얼"
    case postech = "포스텍 시설 정복"
    case tool = "학생 계정 툴 신청"
}

@Model
class Quest {
    // 기본 정보
    var id: UUID
    var title: String

    var steps: [QuestStep]

//    var stepCount: Int {
//        steps.count
//    }

    var isCompleted: Bool

    // 추천 시작일
    var recommendedDate: Date?
    // 기간(시작, 종료)
    var startDate: Date?
    var endDate: Date?
    
    // 카테고리
    var category: QuestCategory?
    
    // 알림 관련
    var isNotificationEnabled: Bool
    var notificationID: String?
    var notificationTime: Date?
    
    
    init(
        id: UUID = UUID(),
        title: String,
        steps: [QuestStep] = [],
        isCompleted: Bool = false,
        recommendedDate: Date? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        category: QuestCategory? = nil,
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

    /// 특정 Index의 Step을 진행할 수 있는지 확인
    func canUnlockStep(at index: Int) -> Bool {
        // 첫 번째 단계는 무조건 진행 가능
        if index == 0 { return true }
        
        // 이전 단계가 완료되었는지 확인
        return steps[index - 1].isCompleted
    }
    
    /// 특정 퀘스트 완료 처리
    func toggleStepCompletion(at index: Int) {
        // 잠금 해제되지 않은 상태면 무시
        guard canUnlockStep(at: index) else { return }
        
        steps[index].isCompleted.toggle()
    }
}
