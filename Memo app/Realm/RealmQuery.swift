//
//  RealmQuery.swift
//  KANGDIARY
//
//  Created by Kanghos on 2021/11/05.
//

import UIKit
import RealmSwift

extension UIViewController {
    
    func searchQueryFromMemo(text: String) -> Results<Memo> {
    
        let localRealm = try! Realm()
        
        //검색어가 제목과 본문에 있는 것을 필터링하여 반환
        let search = localRealm.objects(Memo.self).filter("title CONTAINS[c] '\(text)' OR content CONTAINS[c] '\(text)'")
        print("search : \(search)")
        
        return search
    }
    
    func getAllMemo() -> Results<Memo> {
        let localRealm = try! Realm()
        
        let memos = localRealm.objects(Memo.self).sorted(byKeyPath: "writeDate", ascending: true)
        
        return memos
    }
    
    func getAllCount() -> Int {
        
        let localRealm = try! Realm()
        let count = localRealm.objects(Memo.self).count
        
        return count
    }
}
