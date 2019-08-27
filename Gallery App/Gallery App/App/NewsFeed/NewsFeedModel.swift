//
//  NewsFeedModel.swift
//  Indegene Assigment
//
//  Created by Senthil iMAC on 27/08/19.
//  Copyright © 2019 Senthil. All rights reserved.
//  @senmdu96

import UIKit

struct NewsFeedModel {

    var image : UIImage?
    var caption  : String?
    var videoUrl : String?
    var pdfUrl : String?
    
    func getSize() -> CGSize
    {
        return CGSize(width: image?.size.width ?? 250, height: image?.size.height ?? 250)
    }
}
