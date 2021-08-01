//
//  ContentView.swift
//  GesureApp
//
//  Created by ChoiHyeMin on 2021/07/08.
//

import SwiftUI

struct ContentView: View {
    
    @State var magnification = CGFloat(1.0) // CG (Core Graphics) : 아이폰 정통 그래픽 관련 ~
    @GestureState var offset = CGSize.zero
    @State var dragEnabled = false
    
    var body: some View {
        
//        let tapGesture = TapGesture(count: 2) // Double Tap이어야만 인식된다.
//            .onEnded{ NSLog("Tapped") }
//
//        let longPressGesture = LongPressGesture(minimumDuration: 3, maximumDistance: 5) // 3초에서 5초 사이를 인식
//            .onEnded{ _ in NSLog("Long pressed") }
//
//        let magGesture = MagnificationGesture(minimumScaleDelta: 0) // 크기 키우기 ~ magnification
//            .onChanged {
//                value in
//                print("Mag value = \(value)")
//                self.magnification = value
//            } // 처음보다 몇 배 늘어났는지
//            .onEnded { value in NSLog("MagGesture Ended : \(value)") }
//
//
//        let dragGesture = DragGesture() // 위치 바꾸기 offset
//            .updating( $offset ){dv, state, transaction in
//                state = dv.translation
//            }
        
        let lpAndDrag = LongPressGesture(minimumDuration: 1.0) // longPress 했을 때만 drag 가능하도록
            .onEnded { _ in
                self.dragEnabled = true
                print("drag enabled")
            }
            .sequenced(before: DragGesture())
            .updating( $offset ){ value, state, stransaction in
                switch value{
                case .first(true):
                    print("Long Press in Progress")
                case .second(true, let drag):
                    state = drag?.translation ?? .zero
                default :
                    break
                }
                //state = value.second?.transaction ?? .zero
                
            }
            .onEnded { _ in
                self.dragEnabled = false
        }
            
            
            
        return VStack {
            
            Image(systemName: "hand.point.right.fill")
                            .font(.largeTitle)
                            .padding()
                            .border(Color.black, width: 2)
                            .scaleEffect(magnification)
                            .offset(offset)
                            .gesture(lpAndDrag)
            //.gesture(tapGesture)
            //.gesture(magGesture)
            //.gesture(longPressGesture)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
