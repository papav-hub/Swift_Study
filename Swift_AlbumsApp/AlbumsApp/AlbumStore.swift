//
//  AlbumStore.swift
//  AlbumsApp
//
//  Created by ChoiHyeMin on 2021/07/07.
//

import Foundation


struct Album: Codable {
    var albumTitle: String
    var artistName: String
    var image: String
}
struct AlbumData: Codable {
    var albums: [Album]
}
class AlbumStore : ObservableObject{ // ObservableObject : 수정 & 삭제하기 위해서
    static let singleton = AlbumStore() // singleton Pattrern 하나밖에 없는 객체
    @Published var albums = [Album]() // Publised : 수정 & 삭제하기 위해서
    
    
    func load() {
        // String > url > date > json obj //
        guard let url = Bundle.main.url(forResource: "res/albums.json", withExtension: "") else {
            print("albums.json not found !!")
            return
        }
        print("Loading from: \(url)...")
        guard let data = try? Data(contentsOf: url) else {  // 실패한다면 data는 nil이 된다.
            print("Could not read from \(url)")
            return
        }
        let decoder = JSONDecoder()
        guard let albumData = try? decoder.decode(AlbumData.self, from: data) else {
            print("Decode failed")
            return
        }
        self.albums = albumData.albums
        print("Loaded Albums: \(albums.count)")
    }
}
