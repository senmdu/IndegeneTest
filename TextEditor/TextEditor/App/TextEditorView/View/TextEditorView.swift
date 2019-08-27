//
//  ProductDetailView.swift
//  Indegene Assigment
//
//  Created by Senthil iMAC on 27/08/19.
//  Copyright © 2019 Senthil. All rights reserved.
//  @senmdu96

import UIKit

class TextEditorView: UIViewController{
    
// MARK: - DataSource Properties
    

    
// MARK:- UI Properties
    
    private var textView: UITextView = {
        let detailLabel = UITextView(frame: .zero)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textAlignment = .left
        detailLabel.textColor = .black
        detailLabel.font =  UIFont.systemFont(ofSize: 18)
        return detailLabel
    }()
    
    let imagePicker = UIImagePickerController()
    

    private var bold = UIBarButtonItem(title: "Bold", style: .plain, target: self, action: #selector(makeBold))
    private var italic = UIBarButtonItem(title: "Italic", style: .plain, target: self, action: #selector(makeItalic))

// MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.intialize()
        
    }

// MARK: - UI Methods
    
    fileprivate func loadUI() {
        view.backgroundColor = .white
        self.view.addSubview(textView)
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        textView.delegate = self
        imagePicker.delegate = self
        
        let add = UIBarButtonItem(title: "Add Image", style: .plain, target: self, action: #selector(addImage))
        self.navigationItem.rightBarButtonItems = [bold,italic,add]
        
        
    }
    
// MARK: - Data Binding&Loading Methods
    
    fileprivate func intialize() {
        self.title = "Text Editor"
        self.textView.becomeFirstResponder()
    }
    
    @objc fileprivate func makeBold() {
        bold.style = .done
        italic.style = .plain

        var attributes = textView.typingAttributes
        attributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 18)
        textView.typingAttributes = attributes
    }
    
    @objc fileprivate func makeItalic() {
        italic.style = .done
        bold.style = .plain
    
        var attributes = textView.typingAttributes
        attributes[NSAttributedString.Key.font] = UIFont.italicSystemFont(ofSize: 18)
        textView.typingAttributes = attributes
    }
    
    @objc fileprivate func addImage() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "error", message: "enable camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    fileprivate func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}




    // MARK: - Delegate Methods
    
extension TextEditorView : UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    func textViewDidChange(_ textView: UITextView) {
        var attributes = textView.typingAttributes
        if attributes[NSAttributedString.Key.font] as? UIFont == UIFont.boldSystemFont(ofSize: 18) {
            bold.style = .done
            italic.style = .plain
        } else if attributes[NSAttributedString.Key.font] as? UIFont == UIFont.italicSystemFont(ofSize: 18) {
            italic.style = .done
            bold.style = .plain
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let attachment = NSTextAttachment()
            attachment.image = pickedImage
            attachment.bounds = CGRect.init(x: 0, y: 0, width: 250, height: 250)
            let attString = NSAttributedString(attachment: attachment)
            textView.textStorage.insert(attString, at: textView.selectedRange.location)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
