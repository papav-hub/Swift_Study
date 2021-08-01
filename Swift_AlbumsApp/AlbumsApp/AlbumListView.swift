//
//  ContentView.swift
//  AlbumsApp
//
//  Created by ChoiHyeMin on 2021/07/07.
//

import SwiftUI

extension Album : Identifiable {
    var id : String { albumTitle }
}

struct AlbumListView: View {
    @ObservedObject var albumStore = AlbumStore.singleton // 수정 & 삭제한거 저장하기 위해서
    
    var body: some View {
        NavigationView {
            List {
                ForEach (AlbumStore.singleton.albums) { album in
                    AlbumCell(album: album)
                }
                .onDelete(perform : deleteAlbum) // 삭제
                .onMove(perform: moveAlbum) // 순서 수정
                
            }
            .navigationBarItems(trailing: EditButton()) // 왼쪽에서 오른쪽으로 쓰는 경우 // 오른쪽에서 왼쪽은 반대로 적기!
            .navigationBarTitle(Text("Albums"))
            
            Text("앨범 총 개수 : \(AlbumStore.singleton.albums.count)").padding()
        }
    }
    
    func deleteAlbum (at offsets : IndexSet){ // 삭제
        albumStore.albums.remove(atOffsets: offsets)
    }
    
    func moveAlbum(from src : IndexSet, to dst : Int){ // 수정
        albumStore.albums.move(fromOffsets: src, toOffset: dst)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}

struct AlbumCell: View {
    let album: Album
    @State var image : Image?
    var body: some View {
            NavigationLink(destination: AlbumDetailView(album: album)){
                
                HStack {
                    loadAlbumImage().resizable().frame(width: 56, height: 56, alignment: .center)
                    VStack(alignment:.leading) {
                        Text(album.albumTitle.trimmingCharacters(in: .whitespacesAndNewlines)).foregroundColor(Color.argb(0xFF4B89DC)).frame(height : 50).lineLimit(1)
                        Text(album.artistName.trimmingCharacters(in: .whitespacesAndNewlines)).foregroundColor(.argb(0xFF333333)).lineLimit(1)
                    }
                }
            }
    }
    
    
    func loadAlbumImage() -> Image{
        if let image = image {
            return image
        }
//        if(image != nil){
//            return nil!
//        } // 위랑 같은 내용!
        
        
        return ImageStore.load(strUrl: album.image) { image in
            self.image = image
        }
    
    }
}

extension Color {
    static func argb(_ argb : UInt32) -> Color {
        let a = Double(argb >> 24 & 0xFF) / 255.0 // shift 연산
        let r = Double(argb >> 16 & 0xFF) / 255.0
        let g = Double(argb >> 8 & 0xFF) / 255.0
        let b = Double(argb & 0xFF) / 255.0
        let color = Color(.sRGB, red : r, green : g, blue : b, opacity: a)
        return color
    }
}


struct AlbumCell_Previews : PreviewProvider {
    static var previews : some View {
        List{
            AlbumCell(album : Album(albumTitle : "HELLO1", artistName: "artist1", image : "url1"))
            AlbumCell(album : Album(albumTitle : "HELLO2", artistName: "artist2", image : "url2"))
            AlbumCell(album : Album(albumTitle : "HELLO3", artistName: "artist3", image : "url3"))
        }
    }
}
