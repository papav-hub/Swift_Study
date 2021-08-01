//
//  ContentView.swift
//  ImageSwitcher
//
//  Created by ChoiHyeMin on 2021/07/06.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var count = 0
    let ImageArray : [String] = ["cat1", "cat2", "cat3", "cat4", "cat5"]
    
    @State var userName = ""
    @State var showsImage = true
    @State var opacity = 0.0
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Button(action:onBtnLeft){
                        Image("prev", label : Text("first")).resizable(resizingMode:.stretch).frame(width: 64, height: 64, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.disabled(count == 0)

                    
                    
                    Text("\(count+1) / \(ImageArray.count) ").font(.largeTitle).padding(.horizontal, 50.0).background(Color.blue)
                    
                    
                    
                    Button(action:onBtnRight){
                        Image("next", label : Text("Second")).resizable(resizingMode : .stretch).frame(width:64, height:64, alignment : .center)
                    }.disabled(count == ImageArray.count - 1)
                    
                    
                }
                
                
                //TextField("Your name", text: $userName).keyboardType(.phonePad)
                
                
                //Text(userName)
                /*Toggle(isOn : $showsImage){
                    Text("Shows Image")
                }
                
                Slider(value: $opacity){
                }*/
                
                
                
            }
            Image(ImageArray[count]).resizable()
                .aspectRatio(contentMode: .fit).opacity(showsImage ? 1.0 : 0.3)
            
            //Image(ImageArray[count]).opacity(opacity)
            Spacer()
        }
    }
    
    func onBtnLeft(){
        count -= 1
    }
    func onBtnRight(){
        count += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
