//
//  C2App.swift
//  C2
//
//  Created by 이은지 on 4/19/26.
//

import SwiftUI
import SwiftData

@main
struct C2App: App {
    // 커스텀 ModelContainer 생성 및 초기 데이터 주입
    static let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Quest.self,
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            // 1. 컨테이너 생성
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let context = container.mainContext // 데이터를 다룰 Context
            
            // 데이터 초기화: 기존 퀘스트와 퀘스트 스텝 모두 삭제
            try context.delete(model: Quest.self)
            try context.delete(model: QuestStep.self)
            
            // 2. 기존 데이터가 있는지 확인
            let descriptor = FetchDescriptor<Quest>()
            let existingQuests = try context.fetch(descriptor)
            
            // 3. 데이터가 비어있을 때만(최초 실행 시) 기본 데이터 추가
            if existingQuests.isEmpty {
                let defaultQuests = [
                    Quest(
                        title: "임시 출입증과 장비 수령",
                        steps: [
                            QuestStep(content: "신분증을 지참하세요.", order: 0),
                            QuestStep(content: "C5를 방문하세요.", order: 1),
                            QuestStep(content: "6층으로 올라가세요.", order: 2),
                            QuestStep(content: "데스크에서 임시 출입증을 수령하세요.", order: 3),
                            QuestStep(content: "오디토리움에서 맥북과 아이폰을 수령하세요.", order: 4)
                        ],
                        recommendedDate: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
                        category: .academy
                    ),
                    Quest(
                        title: "포스텍 시설 정복",
                        steps: [
                            QuestStep(content: "도서관 출입증 발급", order: 0),
                            QuestStep(content: "학생 식당 메뉴 구경하기", order: 1)
                        ],
                        recommendedDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(),
                        category: .postech
                    ),
                    Quest(
                        title: "소프트웨어 설치",
                        steps: [
                            QuestStep(content: "Xcode 설치", order: 0),
                            QuestStep(content: "Notion 학생 계정 연동", order: 1)
                        ],
                        recommendedDate: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(),
                        category: .tool
                    )
                ]
                
                // Context에 추가
                for quest in defaultQuests {
                    context.insert(quest)
                }
                
                // 일단 즉시 저장해.
                try context.save()
            }
            
            return container
        } catch {
            fatalError("ModelContainer 생성 실패...! \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // .modelContainer(for: Quest.self)
        .modelContainer(C2App.sharedModelContainer) // 커스텀 컨테이너
    }
}
