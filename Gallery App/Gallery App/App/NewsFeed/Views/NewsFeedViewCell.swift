//
//  Indegene Assigment
//
//  Created by Senthil iMAC on 27/08/19.
//  Copyright © 2019 Senthil. All rights reserved.
//  @senmdu96


import UIKit

class NewsFeedViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "NewsFeedViewCell"
    
    var imageVw: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var labelText: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var imageVwHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         self.loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    fileprivate func loadUI() {
        self.contentView.addSubview(imageVw)
        self.contentView.addSubview(labelText)
        self.setConstraints()
    }
    
    fileprivate func setConstraints() {
        
        //ImageView
        let topImage = NSLayoutConstraint(item: imageVw, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let leftImage = NSLayoutConstraint(item: imageVw, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let rightImage = NSLayoutConstraint(item: imageVw, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        imageVwHeight = NSLayoutConstraint(item: imageVw, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        contentView.addConstraints([topImage, leftImage, rightImage, imageVwHeight])
        
        //label
        let topLabel = NSLayoutConstraint(item: labelText, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageVw, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)
        let leftLabel = NSLayoutConstraint(item: labelText, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 8)
        let rightLabel = NSLayoutConstraint(item: labelText, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 8)
        let bottomLabel = NSLayoutConstraint(item: labelText, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 4)
        contentView.addConstraints([topLabel, leftLabel, rightLabel, bottomLabel])
    }

 
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributs =  layoutAttributes as? PintrestLayoutAttributes {
            
            imageVwHeight?.constant =  attributs.photoHeight
            self.layoutIfNeeded()
        }
    }
}
