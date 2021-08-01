//
//  MainMenuView.swift
//  MatchGameApp
//
//  Created by ChoiHyeMin on 2021/07/09.
//

import SwiftUI

struct MainMenuView: View {
    
    let resourcePrefixes = [ "f", "t" ] // 사진 식별자
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators : false){
                    VStack (spacing : 10) {
                        ForEach (resourcePrefixes, id : \.self) { prefix in
                            MenuItemView(prefix : prefix)
                        }
                    }
//                    Text("WELCOME TO").frame(height : 400)
//                    Text("CHM's First Game!").frame(height : 400)
                }
            }
            .navigationTitle(Text("Memory Game")).font(.largeTitle).padding()
            .frame(maxWidth : .infinity, maxHeight: .infinity) // frame 크기 키우기
            .background(
                LinearGradient(gradient : Gradient(colors: [.red.opacity(0.5), .yellow.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing
                ).edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct MenuItemView : View {
    let prefix : String
    var body : some View {
        HStack {
            Image("\(prefix)_back").resizable().frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4).padding(.leading)
            NavigationLink(
                destination: ContentView(prefix : prefix),
                label: {
                    Text("Play Game").padding().background(Capsule().stroke(lineWidth: 4.0))
                }
            )
            
        }
        .frame(height : 240)
        .background (
            ZStack {
                Color.white.opacity(0.2).cornerRadius(0.8).padding()
                Image("\(prefix)_bg").resizable().padding(50).opacity(0.25)
            }
        )
        .rotation3DEffect(
            .degrees(20),
            axis: (x: 0.0, y: -0.5, z: 0.0)
        )
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}



