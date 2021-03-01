//
//  AudioPlayerView.swift
//  GloryHub
// https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3
//  Created by Shugaban Media on 28/02/2021.
//

import SwiftUI
import AVKit

struct AudioPlayerView: View {
    // MARK: -- PROPERTIES
    var resource_url: String
    

    // MARK: -- BODY
    var body: some View {
        //Text("AudioPlayerView")
        NavigationView{
            
        }
    }
}

// MARK: -- PREVIEW
struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(resource_url: "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3")
    }
}

