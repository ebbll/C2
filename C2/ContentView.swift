//
//  ContentView.swift
//  C2
//
//  Created by 이은지 on 4/19/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var allQuests: [Quest]
    
    // 오늘 기준 미래가 아닌 퀘스트 필터링
    var filteredRecommendedQuests: [Quest] {
        let now = Date()
        return allQuests.filter { quest in
            guard let recommendedDate = quest.recommendedDate else {
                return true // 시작일이 지정되지 않은 경우 포함
            }
            return recommendedDate <= now
        }
    }
    
    // 카테고리 별 퀘스트 필터링
    func filterCategoryQuests(for category: QuestCategory) -> [Quest] {
        switch category {
        case .all:
            return allQuests
        default :
            return allQuests.filter { $0.category == category }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                NavigationLink {
                    MyProfileView()
                } label: {
                    HStack(spacing: 15) {
                        Image("avatar")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 100))
                        
                        Text("넵튠")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()
                }
                .buttonStyle(.plain)
                // End of Header
                
                // Category Card
                VStack(alignment: .leading) {
                    Text("러너를 위한 정보,자유롭게 탐험해보세요.")
                        .font(.title2)
                    
                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            NavigationLink {
                                ListView(pageTitle: "아카데미 튜토리얼")
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.blue)
                                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
                                    .overlay(Text("아카데미 튜토리얼").foregroundStyle(.white))
                            }
                            
                            NavigationLink {
                                ListView(pageTitle: "포스텍 시설 정복")
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.blue)
                                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
                                    .overlay(Text("포스텍 시설 정복").foregroundStyle(.white))
                            }
                        }
                        NavigationLink {
                            ListView(pageTitle: "학생 계정 툴 신청")
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.blue)
                                .frame(maxWidth: .infinity, minHeight: 76, maxHeight: 76)
                                .overlay(Text("학생 계정 툴 신청").foregroundStyle(.white))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                // End of Category Card
                
                // Today's Recommended Card
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("📋  오늘 하기 좋은 일이에요")
                            .font(.title2)
                        Spacer()
                        
                        NavigationLink {
                            ListView(pageTitle: "오늘 하기 좋은 일이에요")
                        } label: {
                            Text("전체보기")
                                .font(.subheadline)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(filteredRecommendedQuests) { quest in
                                NavigationLink {
                                    DetailView(quest: quest)
                                } label: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.blue)
                                        .frame(width: 250, height: 140)
                                        .overlay(Text(quest.title).foregroundColor(.white))
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                // End of Today's Recommended Card
                
                // Reminder Card
                VStack(alignment: .leading) {
                    HStack {
                        Text("⏰  기한이 얼마 남지 않았어요")
                            .font(.title2)
                        Spacer()
                        
                        NavigationLink {
                            ListView(pageTitle: "기한이 얼마 남지 않았어요")
                        } label: {
                            Text("전체보기")
                                .font(.subheadline)
                        }
                        .buttonStyle(.plain)
                    }
                        
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(allQuests) { quest in
                                NavigationLink {
                                    DetailView(quest: quest)
                                } label: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.blue)
                                        .frame(width: 250, height: 140)
                                        .overlay(Text(quest.title).foregroundColor(.white))
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                // End of Reminder Card
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }
}

 #Preview {
     ContentView()
         .modelContainer(C2App.sharedModelContainer)
 }
