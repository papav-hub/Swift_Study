//
//  ImageAssetHelper.swift
//  MatchGameApp
//
//  Created by ChoiHyeMin on 2021/07/09.
//

import Foundation
import UIKit // UIImage


struct ImageAssetHelper { // 이미지 개수 세는 코드
    static func count (prefix : String, number : Int) -> Int {
        var count = 0
        while true {
            let imageName = String(format : "\(prefix)_%02d_%02d", number, count + 1)
            if UIImage (named : imageName ) == nil { // 제대로 UIImage를 받아오는지 검사
                break
            }
            count += 1
        }
        return count
    }
}
