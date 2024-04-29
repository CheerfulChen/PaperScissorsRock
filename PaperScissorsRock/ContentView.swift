//
//  ContentView.swift
//  PaperScissorsRock
//
//  Created by 颜宇辰 on 2024/4/27.
//

import SwiftUI

struct ContentView: View {
    @State private var action = ["✊", "✌️", "🖐️"]
    @State private var winOrlose = ["赢", "输"]
    @State private var botAction = Int.random(in: 0..<3)
    @State private var chooseInTwo = Int.random(in: 0..<2)
    @State private var trueORfalse = false
    @State private var showResult = false
    
    @State private var score = 0
    @State private var round = 0
    
    @State private var final = false
    @State private var rule = false
    
    var show: String {
        if trueORfalse {
            return "回答正确！"
        } else {
            return "回答错误！"
        }
    }
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [Color(red: 200/255, green: 234/255, blue: 255/255), Color(red: 170/255, green: 198/255, blue: 147/255), Color(red: 190/255, green: 207/255, blue: 211/255), Color(red: 0.76, green: 0.87, blue: 0.96), Color(red: 223/255, green: 227/255, blue: 226/255)], center: .center)
            .ignoresSafeArea()
            VStack() {
                VStack() {
                    Spacer()
                    Text("石头剪刀布")
                        .modifier(Title())
                    Spacer()
                    VStack(spacing: 15) {
                        HStack {
                            Text("我出")
                                .font(.title2.weight(.heavy))
                                .foregroundStyle(.secondary)
                            Text(action[botAction])
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                                .scaleEffect(2)
                                .padding(10)
                        }
                        HStack {
                            Text("如果你想")
                                .font(.title2.weight(.heavy))
                                .foregroundStyle(.secondary)
                            Text(winOrlose[chooseInTwo])
                                .font(.title2.weight(.heavy))
                        }
                        VStack {
                            Text("那么你应该出？")
                                .font(.title2.weight(.heavy))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    Button("游戏规则") {
                        rule = true
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(.secondary)
                    .clipShape(.capsule)
                    .alert("游戏规则", isPresented: $rule) {
                        Button("明白了，开始游戏", action: askQuestion)
                    } message: {
                        Text("每回合系统会先执行动作并放出指令\n你需要根据系统的动作以及指令来选择正确的回应\n(有且仅有一个正确答案)")
                    }
                    Spacer()
                    HStack {
                        ForEach(0..<3) { number in
                            Button(action[number]) {
                                whatCanISay(botAction: botAction, chooseInTwo: chooseInTwo, number: number)
                            }
                            .background(.ultraThinMaterial)
                            .clipShape(.circle)
                            .padding(30)
                            .scaleEffect(3)
                        }
                    }
                    Spacer()
                }
                
                .padding(30)
            }
        }
        .alert(show, isPresented: $showResult) {
            Button("继续", action: askQuestion)
        } message: {
            Text("你的得分是\(score)")
        }
        .alert("游戏结束！", isPresented: $final) {
            Button("重新开始", action: reset)
        } message: {
            Text("你的最终得分是\(score)")
        }
    }
    
    func reset() {
        round = 0
        score = 0
        botAction = Int.random(in: 0...2)
        chooseInTwo = Int.random(in: 0...1)
    }
    
    func askQuestion() {
        botAction = Int.random(in: 0...2)
        chooseInTwo = Int.random(in: 0...1)
    }
    
    func whatCanISay (botAction: Int, chooseInTwo: Int, number: Int) {
        showResult = true
        round += 1
        
        if botAction == 0 {
            if chooseInTwo == 0 {
                if number == 2 {
                    trueORfalse = true
                    score += 2
                } else {
                    trueORfalse = false
                    score -= 1
                }
            } else {
                if number == 1 {
                    trueORfalse = true
                    score += 2
                } else {
                    trueORfalse = false
                    score -= 1
                }
            }
        } else if botAction == 1 {
            if chooseInTwo == 0 {
                if number == 0 {
                    trueORfalse = true
                    score += 2
                } else {
                    trueORfalse = false
                    score -= 1
                }
            } else {
                if number == 2 {
                    trueORfalse = true
                    score += 2
                } else {
                    trueORfalse = false
                    score -= 1
                }
            }
        } else {
            if chooseInTwo == 0 {
                if number == 1 {
                    trueORfalse = true
                    score += 2
                } else {
                    trueORfalse = false
                    score -= 1
                }
            } else {
                if number == 0 {
                    trueORfalse = true
                    score += 2
                } else {
                    trueORfalse = false
                    score -= 1
                }
            }
        }
        
        if score < 0 {
            score = 0
        }
        
        if round == 10 {
            final = true
            showResult = false
        }
    }
    
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(Color(red: 0.1, green: 0.2, blue: 0.45))
            .padding()
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

#Preview {
    ContentView()
}
