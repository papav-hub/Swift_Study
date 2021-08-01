//
//  ImageStore.swift
//  AlbumsApp
//
//  Created by ChoiHyeMin on 2021/07/07.
//

import Foundation
import UIKit
import SwiftUI

class ImageStore {
    
    static var cache = [String : Image]() // 딕셔너리
    
    
    static func load(strUrl : String, onDownload : @escaping (Image)->Void) -> Image { // String url 넘어옴
        
        if let image = cache[strUrl]{ // 메모리 캐시 안에 이미 다운로드 되어있는 이미지 사용
            NSLog("Already Downloaded!")
            return image
        }
        
        guard let url = URL(string : strUrl) else { // url객체 변환 시도
            print("Invalid URL : \(strUrl)")
            return Image(systemName : "wifi")
        }
        
        
        
        OperationQueue().addOperation { // 작업을 큐에 넣고 끝 // 나중에 새로운 쓰레드에서 실행
            guard let data = try?Data(contentsOf : url) else { // data loading // network로 다운로드 받음 -> 시간 오래 걸림 // MainThread에서 하지 않을 것!!!
                print("Failed to load from \(strUrl)")
                return
            }
            
            guard let uiImage = UIImage(data : data) else { // image로 디코딩
                print("Not an image data : \(strUrl)")
                return
            }
            
            // 다운로드 시작 로그
            NSLog("start : \(strUrl)")
            
            URLSession.shared.dataTask(with: url) { data, resp, err in // dataTask : Task를 시작시키지 않고, 만들기만 함.
                var image : Image?
                if let data = data {
                    if let uiImage = UIImage(data : data){
                        image = Image(uiImage : uiImage)
                    }
                }

                
                OperationQueue.main.addOperation { // main 쓰레드에서 실행하도록 한다.
                    
                    if(image != nil){ // 이미지 다운로드가 잘 되었다면, 해당 이미지를 캐싱 
                        cache[strUrl] = image
                    }
                    
                    cache[strUrl] = image
                    
                    NSLog("end \(strUrl)") // 다운로드 끝나서 리턴하는 시점에 로그
                    
                    onDownload(image ?? Image(systemName : "cat")) // onDownload에 이미지 전달
                    
                }
            }.resume() // Task 시작
            

        } // 새로운 쓰레드에서 돌리기 위함
        
        
        return Image("cat")
    }
}
