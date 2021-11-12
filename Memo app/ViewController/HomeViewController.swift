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
    var tasks : Results<Memo>! {
        didSet {
            tasks = getAllMemo()
            
        }
    }
    var memos:[Results<Memo>]! {
        didSet {
            //Fixed
            let fixedMemo = tasks.filter("fixed == true").sorted(byKeyPath: "writeDate", ascending: false)
            
            //Non-Fixed
            let unfixedMemo = tasks.filter("fixed == false").sorted(byKeyPath: "writeDate", ascending: false)
            
            let text = searchBar?.text ?? ""
            
            let searchedMemo = tasks.filter("title CONTAINS[c] '\(text)' OR content CONTAINS[c] '\(text)'")
            memos = [fixedMemo, unfixedMemo, searchedMemo]
            
        }
    }
    
    var foundCount:Int = 0 {
        didSet {
            
            foundCount = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: MemoTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: MemoTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = CGFloat(20)
        countLabel.font = UIFont.tableViewTitle
        
        //Realm
        tasks = getAllMemo()
        
        //Fixed
        let fixedMemo = tasks.filter("fixed == true").sorted(byKeyPath: "writeDate", ascending: true)
        
        //Non-Fixed
        let unfixedMemo = tasks.filter("fixed == false").sorted(byKeyPath: "writeDate", ascending: true)
        
        memos = [fixedMemo, unfixedMemo]
        
        //앱에 데이터가 없을 경우, 환영 메세지 출력
        //최초 실행 체크 : 유저 디폴트로 해야할 것 같음
        if tasks.count == 0 {
            
            let sb = UIStoryboard(name: "WelcomePopUp", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "WelcomePopUpViewController") as! WelcomePopUpViewController
            vc.modalPresentationStyle = .formSheet
            vc.modalTransitionStyle = .coverVertical
            
            //문제 모달 뷰 백그라운드가 검정색으로 나옴.
            //Opacity 조정 해보았으나 안 됨, 클리어 컬러도 안 됨.
            present(vc, animated: true, completion: nil)
            
        }
        
        //검색 section[2] 서치바에 아무 값이 없을 경우 숨김.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateLabel()
    }
    
    func updateLabel(){
        tableView.reloadData()
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        countLabel.text =  "\(numberFormat.string(for: getAllCount()) ?? "0")개의 메모"
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return Memo.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memos[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        let data = memos[indexPath.section][indexPath.row]
        cell.configureCell(data : data)
  
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0 : return memos[0].count > 0 ? "고정된 메모" : ""
        case 1 : return "메모"
        default : return foundCount == 0 ? "" : "\(foundCount)개 찾음"
            
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var buttonImageName : String!
        
        if indexPath.section == 0 {
            buttonImageName = "pin.slash.fill"
        } else {
            buttonImageName = "pin.fill"
        }
        
        let fixed = UIContextualAction(style: .normal, title: "") { action, view, completeHandler in
            
            //고정메모가 5개 이상 인지 체크
            let task = self.memos[indexPath.section][indexPath.row]
            if self.memos[0].count > 4 {
                
                // 5 이상이면 가장 오래된 메모 순서 상으로 가장 마지막 고정 해제
                let oldestFixedMemo = self.memos[0][4]
                self.updateQueryFixedState(task: oldestFixedMemo)
            }
            self.updateQueryFixedState(task: task)
            tableView.reloadData()
            print(task)
            completeHandler(true)
        }
        
        fixed.image = UIImage(systemName: buttonImageName)
        fixed.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [fixed])
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "") { action, view, completeHandler in
            
            
            let alert = UIAlertController(title: "", message: "삭제하시겠습니까?", preferredStyle: .alert)
            
            //2. UIalertAction 생성 : 버튼들..
            let ok = UIAlertAction(title: "삭제", style:  .default) { _ in
                
                let task = self.memos[indexPath.section][indexPath.row]
                self.deleteQueryMemo(task: task)
                self.updateLabel()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            
            //4. Present Modal 형식
            self.present(alert, animated: true, completion: nil)
            
            completeHandler(true)
        }
        
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "EditMemo", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EditMemoViewController") as! EditMemoViewController
        //nav.pushViewController(vc, animated: true)
        let data = memos[indexPath.section][indexPath.row]
        vc.contentData = data.title + "\n" + (data.content ?? "")
        vc.isEdit = true
        print(data)
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

