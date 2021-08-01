//
//  DetailView.swift
//  ListApp1
//
//  Created by ChoiHyeMin on 2021/07/07.
//

import SwiftUI

struct DetailView: View {
    let country : Country
    var body: some View {
        VStack{
            Image(country.file).resizable().frame(width:200, height:200, alignment:.center).padding()
            Spacer()
            Text(country.name).font(.largeTitle).fontWeight(.heavy)
            Spacer()
            
        }
        .navigationBarTitle(Text(country.name), displayMode: .inline) // 위에 제목
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(country: Nations.continents.first!.countries.first!)
    }
}
