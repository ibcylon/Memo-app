//
//  MemoTableViewCell.swift
//  Memo app
//
//  Created by Kanghos on 2021/11/08.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    
    static let identifier = "MemoTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writeDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        titleLabel.font = UIFont.titleFont
        contentLabel.font = UIFont.contentFont
        writeDateLabel.font = UIFont.contentFont
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(data : Memo) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        
        //현재 날짜 기준으로 다르게 표시
        //1. 1) 오늘 2) 이번 주 3) 그 외
        let dateString : String
        
        //일자 차이 구하기
        //출처 - soooprmx 블로그
        do {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day]
            formatter.unitsStyle = .full   // < - 이유 알아 볼 것
            if let daysString = formatter.string(from: data.writeDate, to: Date()) {
                
                switch Int(daysString) ?? 0 {
                case 0 ..< 1 :  dateString = DateFormatter.todayFormat.string(from: data.writeDate)
                case 1 ..< 7 : dateString = "\(DateFormatter.currentWeekFormat.string(from: data.writeDate))요일"
                default : dateString = DateFormatter.defaultFormat.string(from: data.writeDate)
                }
                
                writeDateLabel.text = dateString
            }
            
        }
        
        
    }
    
}
