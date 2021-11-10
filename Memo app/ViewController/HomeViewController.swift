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
    @IBOutlet weak var countLabel: UILabel!
    
    let localRealm  = try! Realm()
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
        let welcomeMessage = "처음 오셨군요! \n 환영합니다. \n 당신만의 메모를 작성학고\n 관리해보세요!"
        let alert = UIAlertController(title: "ㅌ", message: welcomeMessage, preferredStyle: .alert)
        
        //2. UIalertAction 생성 : 버튼들..
        let ok = UIAlertAction(title: "확인", style:  .default)
        
        alert.addAction(ok)
        
        //4. Present Modal 형식
        present(alert, animated: true, completion: nil)
        }
        
        countLabel.text = "\(getAllCount())개의 메모"
        countLabel.font = UIFont(name: "system", size: 40)
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        //Fixed
//        let fixedMemo = tasks.filter("fixed == true").sorted(byKeyPath: "writeDate", ascending: true)
//
//        //Non-Fixed
//        let unfixedMemo = tasks.filter("fixed == false").sorted(byKeyPath: "writeDate", ascending: true)
//
//        if section == 0 {
//            return fixedMemo.count
//        } else {
//            return unfixedMemo.count
//        }
        
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

    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var buttonImageName : String!
        
        if indexPath.section == 0 {
            buttonImageName = "pin.fill"
        } else {
            buttonImageName = "pin.slash.fill"
        }
        
        let fixed = UIContextualAction(style: .normal, title: "") { action, view, completeHandler in
            completeHandler(true)
        }
        
        fixed.image = UIImage(systemName: buttonImageName)
        fixed.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [fixed])
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
}


