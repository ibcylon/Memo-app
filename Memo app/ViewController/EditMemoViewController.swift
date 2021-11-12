//
//  EditMemoViewController.swift
//  Memo app
//
//  Created by Kanghos on 2021/11/08.
//

import UIKit

class EditMemoViewController: UIViewController {
    
    let backButtonTitle = "메모"
    var contentData:String = ""
    var isEdit:Bool = false {
        didSet {
            
        }
    }
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.text = contentData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: backButtonTitle, style: .plain, target: self, action: #selector(dismissView))
        
        let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonClicked))
        
        let save = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItems = [save, share]
        
        print(isEdit)
    }
    
    @objc func dismissView(){
        self.navigationController?.popViewController(animated: true)
    }
    func presentActivityView(text : String){
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    @objc func shareButtonClicked(){
        
        if let text = contentTextView.text {
            presentActivityView(text: text)
        }
    }
    
    @objc func saveButtonClicked(){
        
        var title:String = ""
        var contentString:String = ""
        var newLineIndex:String.Index?
        if let content = contentTextView.text {
            
            
            for char in content {
                if char.isNewline {
                    newLineIndex = content.firstIndex(of: char)
                    break
                }
            }
            
            
            if let newIndex = newLineIndex {
                
                title = String(content[content.startIndex ..< newIndex])
                contentString = String(content[newIndex ..< content.endIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                
                title = content
                contentString = "추가 텍스트 없음"
            }
            print(title)
            print(contentString)
            insertQueryMemo(title: title, content: contentString)
            
        }
    }
}

extension UITextView : UITextViewDelegate {
    
}


