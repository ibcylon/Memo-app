//
//  WelcomePopUpViewController.swift
//  Memo app
//
//  Created by Kanghos on 2021/11/12.
//

import UIKit

class WelcomePopUpViewController: UIViewController {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        messageView.layer.cornerRadius = 10
        messageView.backgroundColor = .lightGray
        messageLabel.text = "처음 오셨군요!\n환영합니다.\n당신만의 메모를 작성학고\n관리해보세요!"
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        okButton.layer.cornerRadius = 10
        okButton.backgroundColor = .orange
        okButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
    }
    @IBAction func okButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

   

}
