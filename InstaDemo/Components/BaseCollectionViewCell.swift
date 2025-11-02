//
//  BaseCollectionViewCell.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/2/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeText(text: String, alterRange: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        if let range = text.range(of: alterRange) {
            let nsRange = NSRange(range, in: text)
            
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: nsRange)
        }
        
        return attributedString
    }
    
    func changeText(text: String, alterRange1: String, alterRange2: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        if let range = text.range(of: alterRange1) {
            let nsRange = NSRange(range, in: text)
            
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: nsRange)
        }
        
        if let range = text.range(of: alterRange2) {
            let nsRange = NSRange(range, in: text)
            
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: nsRange)
        }
        
        return attributedString
    }
    
    func showDate(dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMMM d"
            
            let formattedDate = displayFormatter.string(from: date)
            return formattedDate
        } else {
            return "Invalid date format"
        }
    }
}
