//
//  ContentView.swift
//  MatchGameApp
//
//  Created by ChoiHyeMin on 2021/07/09.
//

import SwiftUI


struct ContentView: View {
    let prefix : String

    @ObservedObject var game = MemoryGame()
    @State var showRestartAlert = false // alert를 보여줄 것인지 변수
    @Environment(\.presentationMode) var present // 뷰가 화면에 어떻게 나타났는지 저장하는 변수

    var body: some View {
        VStack {
            HStack {
                Text("Memory Game").font(.headline)
                Spacer()
                Text("Flips : \(game.flips)")
            }.padding()
            
            
            GridStack(rows: MemoryGame.dimen.rows, columns: MemoryGame.dimen.cols) { row, col in
                CardView(card: game.card(row: row, col: col), prefix : prefix)
                    .gesture(TapGesture()
                                .onEnded { _ in
                    game.toggle(row:row, col: col)
                })
            }
            //.aspectRatio(CGSize(width : MemoryGame.dimen.cols, height : MemoryGame.dimen.rows), contentMode: .fill)
            
            Spacer()
            
            HStack {
                Button(action : { // back Button
                    present.wrappedValue.dismiss()
                }){
                    Text("Back").padding(.horizontal)
                }
                
                
                Button(action : {
                    showRestartAlert = true
                }){
                    Text("RESTART").padding(.horizontal) // 가로방향으로만 padding, 세로는 조금만
                        //.background(Capsule().Stroke(linewidth : 2.0))// 테두리
                }
                
            }
            
        }
        .background(LinearGradient(
            gradient : Gradient(colors: [.purple.opacity(0.5), .blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .trailing
        ).edgesIgnoringSafeArea(.all) // safe area 색으로 채우기
        )
        .alert(isPresented: $showRestartAlert) { // restart 한번 더 확인 dialog
            Alert(
                title : Text("Restart?"),
                message : Text("Do you want to Restart the game?"),
                primaryButton: .cancel(),
                secondaryButton: .default(Text("Restart")){
                    game.start()
                }
            )
        }
        .navigationBarTitle("", displayMode : .inline) // 위에 공간을 사용하지 않음
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // backButton 불가
        .onAppear() {
            NSLog("onApper")
            game.start() // 다시 접속하면 게임 다시 시작
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(prefix: "f")
    }
}
