//
//  DailyTableViewCell.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let valueLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        selectionStyle = .none
        
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(valueLabel)

        titleLabel.font = Style.font(ofSize: 16.0, weight: .medium)
        titleLabel.textColor = UIColor.label
        titleLabel.textAlignment = .left
        
        subtitleLabel.font = Style.font(ofSize: 14.0, weight: .regular)
        subtitleLabel.textColor = UIColor.secondaryLabel
        subtitleLabel.textAlignment = .left
        
        valueLabel.textAlignment = .right
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: valueLabel.leftAnchor, constant: -10.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10.0).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0.0).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10.0).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0.0).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
    }
    
    /// Used to prepare min and max temperature attributed string and set it to valueLabel
    /// - Parameters:
    ///   - min: min temperature
    ///   - max: max temperature
    func setTemperature(min:Double?, max:Double?) {
        guard let min = min else { return }
        guard let max = max else { return }
        
        /// Max temperature will be bold
        let tempMax:NSAttributedString = NSAttributedString(
            string: min.toCelsius.formattedTemperature,
            attributes: [
                .font : Style.font(ofSize: 16.0, weight: .medium),
                .foregroundColor : UIColor.label
            ]
        )
        
        /// Min temperature will be regular
        let tempMin:NSAttributedString = NSAttributedString(
            string: " / " + max.toCelsius.formattedTemperature,
            attributes: [
                .font : Style.font(ofSize: 16.0, weight: .regular),
                .foregroundColor : UIColor.secondaryLabel
            ]
        )

        let detailsString:NSMutableAttributedString = NSMutableAttributedString()
        detailsString.append(tempMax)
        detailsString.append(tempMin)
        valueLabel.attributedText = detailsString
    }
}
