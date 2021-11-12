//
//  RealmModel.swift
//  KANGDIARY
//
//  Created by Kanghos on 2021/11/02.
//

import Foundation
import RealmSwift

//Memo : Table Name
//@Persisted : Column
class Memo: Object {
    @Persisted var title: String //제목(필수)
    @Persisted var content: String? //본문(옵션)
    @Persisted var writeDate = Date() //작성 날짜
    @Persisted var fixed:Bool // 고정 메모
    
    //: Int, String UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id:ObjectId
    convenience init(title:String, content: String?, writeDate:Date) {
        self.init()
        
        self.title = title
        self.content = content
        self.writeDate = writeDate
        self.fixed = false
    }
    
    static var sections = ["고정된 메모", "메모", "개 검색"]
}
