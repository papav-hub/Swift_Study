//
//  ContentView.swift
//  FirstApp
//
//  Created by ChoiHyeMin on 2021/07/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.slash")
            VStack {
                VStack {
                    Label("Label"/*@END_MENU_TOKEN@*/, systemImage: /*@START_MENU_TOKEN@*/"10.circle")
                        VStack {
                            Text("Hi! This is My First App😆").padding()
                            Button(action: {print("Btn")}) {
                                Text("This is a Button :)")
                            }
                            Button(action : {print("Btn2")}){
                                Text("These are Buttons!😀")
                            }
                            ColorPicker(/*@START_MENU_TOKEN@*/"Title"/*@END_MENU_TOKEN@*/, selection: .constant(.red))
                                .padding(.top)
                    }
                }
                ProgressView(value: /*@START_MENU_TOKEN@*/0.3/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
