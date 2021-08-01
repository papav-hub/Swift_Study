//
//  SecondTabView.swift
//  TabApp
//
//  Created by ChoiHyeMin on 2021/07/08.
//

import SwiftUI

struct SecondTabView: View {
    var body: some View {
        NavigationView{
            List {
                Text("Row 1")
                Text("Row 2")
                Text("Row 3")
                Text("Row 4")
                Text("Row 5")
                Text("Row 6")
                Text("Row 7")
            }
        }
        .tabItem {
            Image(systemName : "2.circle")
            Text("Tab Two")
        }
    }
}

struct SecondTabView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTabView()
    }
}
