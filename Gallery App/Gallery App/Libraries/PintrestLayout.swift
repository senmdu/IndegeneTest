//
//  CustomLayout.swift
//
//  Created by Senthil Kumar on 19/04/18.
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//  Developer : Senthil Kumar (@senmdu96)
//  Reference: https://www.ductran.co/p/pinterest,
//  https://www.raywenderlich.com/164608/uicollectionview-custom-layout-tutorial-pinterest-2

import UIKit

protocol PintrestLayoutDelegate: class {
    
    func collectionView(collectionView:UICollectionView, heightForPhotoAt indexPath:IndexPath,with width:CGFloat) -> CGFloat
    
    func collectionView(collectionView:UICollectionView, heightForCaptionAt indexPath:IndexPath,with width:CGFloat) -> CGFloat
}

class PintrestLayout: UICollectionViewLayout {
    
    
    var numberOfColumns : CGFloat = 2
    var cellPadding : CGFloat = 5.0

    
    weak var delegate : PintrestLayoutDelegate?
    
    private var contentHeight : CGFloat = 0.0
    private var contentWidth  : CGFloat {
        
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    private var attributeCache = [PintrestLayoutAttributes]()
    
    override func prepare() {
        
        if attributeCache.isEmpty {
            
            let columnWidth = contentWidth / numberOfColumns
           
            var xOffset  =  [CGFloat]()
            for column in 0 ..< Int(numberOfColumns)  {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: Int(numberOfColumns) )
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                
                //calculating the frame
                
                let width  =  columnWidth - cellPadding * 2
                
                let photoHeight : CGFloat  = (delegate?.collectionView(collectionView: collectionView!, heightForPhotoAt: indexPath, with: width))!
                let captionHeigt : CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForCaptionAt: indexPath, with: width))!
                
              
                let height =  cellPadding + photoHeight + captionHeigt + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                //create cell attribute
                let attribute = PintrestLayoutAttributes(forCellWith: indexPath)
                attribute.photoHeight = photoHeight
                attribute.frame = insetFrame
                attributeCache.append(attribute)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] =  yOffset[column] + height
                
                if column >= Int(numberOfColumns - 1) {
                    
                    column = 0
                }else {
                    
                    column +=  1
                }
            }
         
        }
        
    }
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        

        return true
    }
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in attributeCache {
            
            if attributes.frame.intersects(rect) {
                
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }

}


class PintrestLayoutAttributes: UICollectionViewLayoutAttributes {
    
    
    var photoHeight : CGFloat = 0.0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        
        let copy = super.copy(with: zone) as! PintrestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let attributes = object as? PintrestLayoutAttributes {
            
            if attributes.photoHeight == photoHeight {
                
                return super.isEqual(object)
            }
        }
        
        return false
    }
    
}
