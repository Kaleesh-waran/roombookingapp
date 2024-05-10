//
//  CustomCollectionViewCell.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//

import Foundation
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
 
    let rightImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let buildingNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let floorNumberLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let roomNumberLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let timeLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let organizerNameLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubview(rightImageView)
        addSubview(buildingNameLabel)
        addSubview(floorNumberLabel)
        addSubview(roomNumberLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(organizerNameLabel)
        NSLayoutConstraint.activate([

            rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            rightImageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            rightImageView.widthAnchor.constraint(equalToConstant: 100),
            rightImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            buildingNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            buildingNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            buildingNameLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -8),
            
            floorNumberLabel.topAnchor.constraint(equalTo: buildingNameLabel.bottomAnchor, constant: 10),
            floorNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            floorNumberLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -8),
            
            roomNumberLabel.topAnchor.constraint(equalTo: floorNumberLabel.bottomAnchor, constant: 10),
            roomNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            roomNumberLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: roomNumberLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -8),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -8),
            
            organizerNameLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            organizerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            organizerNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            organizerNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
