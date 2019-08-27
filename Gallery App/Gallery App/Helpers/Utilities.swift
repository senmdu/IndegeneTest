//
//  Utilities.swift
//  Indegene Assigment
//
//  Created by Senthil iMAC on 27/08/19.
//  Copyright © 2019 Senthil. All rights reserved.
//  @senmdu96



import UIKit
import AVKit

class Utilities {
    
    
   class func videoSnapshot(filePathLocal: String) -> UIImage? {
        
        let vidURL = URL(fileURLWithPath:filePathLocal)
        let asset = AVURLAsset(url: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }

}
