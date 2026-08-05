//
//  DetailView.swift
//  C2
//
//  Created by 이은지 on 4/20/26.
//

import SwiftUI
import SwiftData

private struct QuestStepRow: View {
    let step: QuestStep
    let isCurrentStep: Bool
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button(action: onTap) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(step.isCompleted ? .point : .clear)
                        .stroke(isCurrentStep || step.isCompleted ? .point : .gray, lineWidth: 2)
                        .frame(width: 18, height: 18)
                        .shadow(color: isCurrentStep ? .point : .clear, radius: 5)

                    Text(step.order + 1, format: .number)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(isCurrentStep || step.isCompleted ? .point : .gray)
                }
                .padding(10)
            }

            Text(step.content)
                .foregroundStyle(isCurrentStep || step.isCompleted ? .white : .gray)
                .fontWeight(.semibold)

            Spacer()
        }
    }
}

struct DetailView: View {
    @Bindable var quest: Quest
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(.ticket)
            
            VStack(spacing: 40) {
                Image("asset1")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(50)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(quest.sortedSteps) { step in
                            let nextStepOrder = quest.availableSteps()
                            let isCurrentStep = nextStepOrder == step.order
                            let isCompleted = step.isCompleted
                            
                            QuestStepRow(step: step, isCurrentStep: isCurrentStep) {
                                if !isCompleted && isCurrentStep {
                                    step.isCompleted = true
                                }
                            }
                        }
                    }
                }
                
                HStack {
                    ForEach(quest.sortedSteps) { step in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(step.isCompleted ? .point : .inactive)
                            .frame(maxWidth: .infinity, maxHeight: 4)
                    }
                }
                
                if quest.startDate != nil {
                    Button {
                        quest.startDate = nil
                        quest.steps.forEach { step in
                            step.isCompleted = false
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.inactive)
                                .frame(width: 170, height: 40)
                            Text("그만둘래요")
                                .foregroundStyle(.white)
                        }
                    }
                } else {
                    if quest.availableSteps() != -1 {
                        Button {
                            quest.startDate = Date()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.inactive)
                                    .frame(width: 170, height: 40)
                                Text("시작할래요")
                                    .foregroundStyle(.white)
                            }
                        }
                    } else {
                        Button {
                            quest.endDate = Date()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.inactive)
                                    .frame(width: 170, height: 40)
                                Text("다 끝냈어요")
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(quest.title)
        .padding()
        .background {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    let quest: Quest = Quest(
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
    )
    
    DetailView(quest: quest)
}
