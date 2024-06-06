//
//  CustomCollectionViewCell.swift
//  Rest_API_Video
//
//  Created by Admin on 01/06/24.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
        

    
        
        // Настройка ограничений для imageView и textLabel с использованием SnapKit
        imageView.snp.makeConstraints { make in
//            make.height.equalTo(166)
//            make.width.equalTo(166)
//            make.top.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(166) // Высота изображения 166
            make.width.equalTo(166) // Ширина изображения 166
        }
        
        
        textLabel.snp.makeConstraints { make in
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(25) // Высота текста
            make.top.equalTo(imageView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
