//
//  TemperatureTableViewCell.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {

    let temperatureLabel = UILabel()
    let summaryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupTemperatureLabel()
        setupSummaryLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTemperatureLabel() {
        contentView.addSubview(temperatureLabel)

        temperatureLabel.font = Style.font(ofSize: 80.0, weight: .medium)
        temperatureLabel.textColor = UIColor.label
        temperatureLabel.textAlignment = .center

        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        temperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -12.0).isActive = true
    }

    private func setupSummaryLabel() {
        contentView.addSubview(summaryLabel)

        summaryLabel.font = Style.font(ofSize: 16.0, weight: .regular)
        summaryLabel.textColor = UIColor.secondaryLabel
        summaryLabel.textAlignment = .center

        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        summaryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        summaryLabel.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 0.0).isActive = true
    }
}
