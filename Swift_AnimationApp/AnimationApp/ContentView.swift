//
//  ContentView.swift
//  AnimationApp
//
//  Created by ChoiHyeMin on 2021/07/08.
//
// animation(size, location, opacity) <-> transition(true/false)

import SwiftUI

struct ContentView: View {
    @State var rotation = 0.0 // 각도
    @State var scale : CGFloat = 1.0 // 크기
    @State var visibility = false
    @State var spinning = false
    
    var body: some View {
        VStack{
            ZStack { // 겹쳐서 배열
                Circle().stroke(lineWidth: 2).foregroundColor(.blue)
                    .frame(width : 200, height : 200, alignment: .center)
                Image(systemName : "forward.fill")
                    .offset(y:-100)
                    .rotationEffect(.degrees(spinning ? 360 : 0))
                    .animation(.linear(duration: 5).repeatForever(autoreverses : false))
                // autoreverses false 안하면 다시 뒤로 재생하다가 정상으로 재생하는 것 반복함
            }
            .onAppear {
                self.spinning = true
            }
            
            
            Toggle(isOn: $visibility.animation(.linear)) { // animation(.linear) 없으면 애니메이션 적용 안됨!º
                Text("Toggle Text Views").font(.largeTitle)
            }.padding()
            
            
            
            VStack {
                Button(action:onBtn){
                    Text("HitMe🤩").fontWeight(.heavy).font(.largeTitle).padding().rotationEffect(.degrees(rotation))
                        .scaleEffect(scale) // 크기 커짐
                        //.animation(.linear(duration : 0.5)) // 설정 시간 동안 애니메이션 수행
                        .animation(.spring(response: 1, dampingFraction: 0.2, blendDuration: 0)) // 살짝 지나갔다 오는 애니메이션
                    
                    
                    // animation 전에 것들은 애니메이션으로 표현
                    // 뒤에 것들은 바로 적용됩니당

                }
                
                if visibility {
                    Text("Slide").font(.largeTitle).transition(.slide)
                }else {
                    Text("Scale").font(.largeTitle).transition(.scale)
                }
                
                if visibility {
                    Text("Move-Top").font(.largeTitle).transition(.move(edge: .top))
                }else {
                    Text("Opacity").font(.largeTitle).transition(.opacity)
                }
            }
        }
        
    }
    
    
        
        func onBtn(){
            self.rotation = self.rotation < 360 ? self.rotation + 60 : 0
            self.scale = self.scale < 2.8 ? self.scale + 0.2 : 1
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
