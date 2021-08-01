//
//  GridStack.swift
//  MatchGameApp
//
//  Created by ChoiHyeMin on 2021/07/09.
//

import SwiftUI

// 범용적으로 사용할 수 있는 VIEW!

struct GridStack<Content : View> : View {
    
    let rows : Int
    let columns : Int
    let content : (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach (0 ..< rows, id : \.self) { row in
                HStack {
                    ForEach (0 ..< columns, id : \.self) { column in
                        content(row, column).frame(maxWidth : .infinity, maxHeight: .infinity)
                        
                    }
                }
            }
        }
    }
}

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack(rows: 4, columns: 2) { row, col in
            Text("R:\(row) & C:\(col)")
        }.frame(width: 300, height: 500, alignment: .center)
    }
}
