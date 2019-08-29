//
//  ViewController.swift
//  Indegene Assigment
//
//  Created by Senthil iMAC on 27/08/19.
//  Copyright © 2019 Senthil. All rights reserved.
//  @senmdu96


import UIKit
import AVFoundation
import AVKit

class NewsFeedView: UIViewController {

    // MARK:- UI Properties
    var collectionView: UICollectionView = {
       
        let collection = UICollectionView(frame: .zero, collectionViewLayout: PintrestLayout())
        collection.backgroundColor = .black
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var data = [NewsFeedModel]()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadData()
    
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        self.collectionView.performBatchUpdates({
             self.collectionView.setCollectionViewLayout(self.collectionView.collectionViewLayout, animated: true)
            
        }, completion: nil)
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Methods
    
    fileprivate func setupUI() {
        
        self.view.addSubview(collectionView)
        self.title = "Gallery"
        collectionView.register(NewsFeedViewCell.self, forCellWithReuseIdentifier: NewsFeedViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.setConstraints()
        if let layout = collectionView.collectionViewLayout as? PintrestLayout {
            layout.delegate  = self
        } 
        
     
    }
    
    fileprivate func setConstraints() {
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    // MARK: - Data Binding&Loading Methods
    
    fileprivate func loadData() {
        
        guard let video = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        guard let pdf = Bundle.main.path(forResource: "samplePdf", ofType:"pdf") else {
            debugPrint("video not found")
            return
        }
        
        self.data = [NewsFeedModel(image: UIImage(named: "apple.jpg"), caption: "Apple", videoUrl: nil, pdfUrl: nil),
        NewsFeedModel(image: UIImage(named: "apple.jpg"), caption: "Apple", videoUrl: nil, pdfUrl: nil),
        NewsFeedModel(image: UIImage(named: "pdf.png"), caption: "Pdf Example", videoUrl: nil, pdfUrl: pdf),
        NewsFeedModel(image: Utilities.videoSnapshot(filePathLocal: video), caption: "Video", videoUrl: video, pdfUrl: nil),
        NewsFeedModel(image: UIImage(named: "bird.jpeg"), caption: "Bird", videoUrl: nil, pdfUrl: nil),
             NewsFeedModel(image: Utilities.videoSnapshot(filePathLocal: video), caption: "Video 2", videoUrl: video, pdfUrl: nil),
        NewsFeedModel(image: UIImage(named: "apple.jpg"), caption: "Apple", videoUrl: nil, pdfUrl: nil),
        NewsFeedModel(image: UIImage(named: "pdf.png"), caption: "Pdf Example 2", videoUrl: nil, pdfUrl: pdf),
        NewsFeedModel(image: UIImage(named: "bird.jpeg"), caption: "Bird", videoUrl: nil, pdfUrl: nil),
        NewsFeedModel(image: Utilities.videoSnapshot(filePathLocal: video), caption: "Video 3", videoUrl: video, pdfUrl: nil)]
        self.collectionView.reloadData()
    }


}

    // MARK: - Delegate Methods

extension NewsFeedView : UICollectionViewDelegate,UICollectionViewDataSource,PintrestLayoutDelegate,UIScrollViewDelegate{
    
    
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        let imageData = data[indexPath.row]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: imageData.getSize(), insideRect: boundingRect)
        return rect.size.height

    }
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsFeedViewCell.reuseIdentifier, for: indexPath) as! NewsFeedViewCell
        cell.imageVw.image = data[indexPath.row].image
        cell.labelText.text = data[indexPath.row].caption
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let url = data[indexPath.row].videoUrl {
            let player = AVPlayer(url: URL(fileURLWithPath:url))
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }else if let pdf = data[indexPath.row].pdfUrl  {
            let document = PDFDocument(url: URL(fileURLWithPath:pdf))!
            let readerController = PDFViewController.createNew(with: document)
            self.navigationController?.pushViewController(readerController, animated: true)
        }else {
            let imageInfo = JTSImageInfo()
            imageInfo.image = data[indexPath.row].image
            imageInfo.referenceRect = collectionView.frame
            imageInfo.referenceView = collectionView
            
            let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: .image, backgroundStyle: .blurred)
            imageViewer?.show(from: self, transition: .fromOffscreen)
        }
        
    }
    

    
}
