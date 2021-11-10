//
//  EditMemoViewController.swift
//  Memo app
//
//  Created by Kanghos on 2021/11/08.
//

import UIKit

class EditMemoViewController: UIViewController {
    
    let backButtonTitle = "메모"
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "adf", style: .plain, target: self, action: nil)
        
        let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonClicked))
        
        let save = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItems = [save, share]
    }
    
    @objc func shareButtonClicked(){
        
    }
    
    @objc func saveButtonClicked(){
        let content = contentTextView.text
        guard let firstReturnIndex = contentTextView.text.firstIndex(of: "\n") else {
            return }
        
        let title = content![content!.startIndex...firstReturnIndex]
        print(title)
    }
    
}

extension UITextView : UITextViewDelegate {
    
}


