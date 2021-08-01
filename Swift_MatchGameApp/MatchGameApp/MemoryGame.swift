//
//  MemoryGame.swift
//  MatchGameApp
//
//  Created by ChoiHyeMin on 2021/07/09.
//

import Foundation

struct Card {
    var open : Bool? // bool optional
    let number : Int
    
}

class MemoryGame : ObservableObject {
    struct dimen {
        static let cols = 4
        static let rows = 5
    }
    
    var openIndex : Int? // open되어있는 카드의 개수
    @Published var cards : [Card] = []
    @Published var flips = 0 // 뒤집은 횟수
    
    
    init(){ // 객체가 생성될 때
        start()
    }
    func start(){ // 게임이 시작될 때
        flips = 0 // 초기화
        cards = [] // 1차원으로 설계
        let max_num = dimen.cols * dimen.rows / 2
        for n in 1 ... max_num {
            cards.append(Card(open: false, number: n))
            cards.append(Card(open: false, number: n))
        }
        cards = cards.shuffled() // 카드 섞어서 return // shuffle() 쓰면 그 객체에 한에서만 섞어짐(var만 가능)
        // cards.shuffle() // 위와 동일 코드
        flips = 0
        openIndex = nil
    }
    
    func card(row : Int, col : Int) -> Card { // row & col을 주면 card가 나오는 함수
        cards[row * dimen.cols + col]
    }
    
    func toggle(row : Int, col : Int){
        let index = row * dimen.cols + col
        let card = cards[index]
        
        if (card.open == nil || card.open!) { // 카드가 존재하지 않거나 || 오픈되어있는 카드를 건드렸다면 -> 아무일도 일어나지 않음
            return
        }
        
        cards[index].open!.toggle() // true & false 바꿔줌
        
        guard let oidx = openIndex else{ // 카드 뒤집음
            flips += 1
            openIndex = index
            return
        }
        
        let openCard = cards[oidx] // 오픈된 카드를 살펴봄
        if (openCard.number != card.number) { // 오픈된 카드가 다르다면
            flips += 1
            cards[oidx].open = false // 기존에 열려있던 인덱스는 닫고
            openIndex = index // 지금 눌린 인덱스를 저장
            return
        }
        
        remove(at : index)
        remove(at : openIndex!)
        openIndex = nil // 삭제하면 오픈 인덱스가 nil이 되어야 한다.
        
    }
    
    func remove(at index : Int) {
        cards[index].open = nil
    }
}
