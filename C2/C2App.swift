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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Quest.self,
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        // do {
        //     return try ModelContainer(for: schema, configurations: [modelConfiguration])
        // } catch {
        //     fatalError("ModelContainer 생성 실패 \(error)")
        // }

        do {
            // 1. 컨테이너 생성
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let context = container.mainContext // 데이터를 다룰 Context
            
            // 2. 기존 데이터가 있는지 확인
            let descriptor = FetchDescriptor<Quest>()
            let existingQuests = try context.fetch(descriptor)
            
            // 3. 데이터가 비어있을 때만(최초 실행 시) 기본 데이터 추가
            if existingQuests.isEmpty {
                let defaultQuests = [
                    Quest(
                        title: "아카데미 튜토리얼 완료하기",
                        steps: [
                            QuestStep(content: "입학식 참석", order: 0),
                            QuestStep(content: "기숙사 짐 풀기", order: 1),
                            QuestStep(content: "캠퍼스 투어", order: 2)
                        ],
                        category: .academy
                    ),
                    Quest(
                        title: "포스텍 시설 정복",
                        steps: [
                            QuestStep(content: "도서관 출입증 발급", order: 0),
                            QuestStep(content: "학생 식당 메뉴 구경하기", order: 1)
                        ],
                        category: .postech
                    ),
                    Quest(
                        title: "소프트웨어 설치",
                        steps: [
                            QuestStep(content: "Xcode 설치", order: 0),
                            QuestStep(content: "Notion 학생 계정 연동", order: 1)
                        ],
                        category: .tool
                    )
                ]
                
                // Context에 추가
                for quest in defaultQuests {
                    context.insert(quest)
                }
                
                // 즉시 저장
                try context.save()
            }
            
            return container
        } catch {
            fatalError("ModelContainer 생성 실패 \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // .modelContainer(for: Quest.self)
        .modelContainer(sharedModelContainer) // 커스텀 컨테이너 주입
    }
}
