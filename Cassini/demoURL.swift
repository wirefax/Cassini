//
//  demoURL.swift
//  Cassini
//
//  Created by Maksym Logvin on 3/5/19.
//  Copyright © 2019 Maksym Logvin. All rights reserved.
//

import Foundation

struct DemoURLs {
    
    static let stanford = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    //static let stanford = URL(string: "https://upload.wikimedia.org/wikipedia/commons/c/cd/Stanford_Oval_May_2011_panorama.jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini":"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia22226.jpg",
            "Earth":"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/blackmarble_2016_americas_composite.png",
            "Saturn":"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/nh-psychedelic-pluto_pca.png"
        ]
        
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
    
}
