//
//  CardView.swift
//  MatchGameApp
//
//  Created by ChoiHyeMin on 2021/07/09.
//

import SwiftUI

// 카드 하나만 보이는 VIEW!

struct CardView: View {
    let card : Card
    let prefix : String
    var timer = Timer.publish(every : 0.1, on : .main, in : .common).autoconnect() // animation 사용하기 위한 변수
    let count : Int // frame 개수
    init(card : Card, prefix : String){
        self.card = card
        self.prefix = prefix
        self.count = ImageAssetHelper.count(prefix: prefix, number: card.number)
    }
    @State var frameIndex = 1
    
    var body: some View {
        if let open = card.open{
            Image(open ? String(format:"\(prefix)_%02d_%02d", card.number, frameIndex) : "\(prefix)_back") // true, false에 따라 이미지가 다름
            .resizable().aspectRatio(1, contentMode: .fit) // 크기 맞추기
                .onReceive( timer ) { _ in // animation
                    frameIndex = frameIndex < count ? frameIndex + 1 : 1
                }
        }else{
            Image(systemName: "x.circle").resizable().aspectRatio(1, contentMode: .fit)
                .opacity(0.1) // 흐리게
        }
        
        //Text("< cardNumber : \(card.number) >")
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack{
                CardView(card: Card(open: false, number: 1), prefix : "f")
                CardView(card: Card(open: nil, number: 1), prefix : "f")
                CardView(card: Card(open: true, number: 1), prefix : "f")
                CardView(card: Card(open: true, number: 2), prefix : "f")
            }
            
            VStack{
                CardView(card: Card(open: false, number: 1), prefix : "t")
                CardView(card: Card(open: nil, number: 1), prefix : "t")
                CardView(card: Card(open: true, number: 1), prefix : "t")
                CardView(card: Card(open: true, number: 2), prefix : "t")
            }

        }
    }
}
