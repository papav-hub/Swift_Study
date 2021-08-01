//
//  AlbumDetailView.swift
//  AlbumsApp
//
//  Created by ChoiHyeMin on 2021/07/08.
//

import SwiftUI

struct AlbumDetailView: View {
    var album : Album
    @State var image : Image?
    
    var body: some View {
        VStack{
            Spacer()
            Text(album.albumTitle).font(.largeTitle)
            loadAlbumImage().resizable().frame(width: 200, height: 200, alignment: .center)
            Text(album.artistName)
            Spacer()
            Spacer()
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

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album(albumTitle: "2집 T-School", artistName: "김태우", image: "http://scgyong.net/thumbs/slow.php/204_192131.jpg"))
    }
}
