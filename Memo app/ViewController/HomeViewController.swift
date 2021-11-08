//
//  ViewController.swift
//  Memo app
//
//  Created by Kanghos on 2021/11/08.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var tasks : Results<Memo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: MemoTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: MemoTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Realm
        tasks = getAllMemo()
        
        
        if tasks.count == 0 {
            //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
            let alert = UIAlertController(title: "ㅌ", message: "처음 오셧군요", preferredStyle: .actionSheet)
            
//            //2. UIalertAction 생성 : 버튼들..
//            let ok = UIAlertAction(title: "iPhone Get!", style: .default)
//            let ok2 = UIAlertAction(title: "iPhone Get2!", style: .default)
//
//            let ipad = UIAlertAction(title: "ipad", style: .destructive)
//            let watch = UIAlertAction(title: "watch", style: .cancel)
//
//            //3. 1 + 2
//            //.cancel is located bottom
//            alert.addAction(ok)
//            alert.addAction(ipad)
//            alert.addAction(watch)
//            alert.addAction(ok2)
            
            //4. Present Modal 형식
            present(alert, animated: true, completion: nil)
        }
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Fixed Memo와 일반 메모 구분하여 return
        
        return tasks.count
    }
    
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}


