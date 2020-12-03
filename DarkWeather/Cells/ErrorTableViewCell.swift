//
//  ErrorTableViewCell.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    let errorLabel = UILabel()
    let errorIcon = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupErrorLabel()
        setupErrorIcon()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupErrorLabel() {
        contentView.addSubview(errorLabel)

        errorLabel.font = Style.font(ofSize: 24.0, weight: .medium)
        errorLabel.textColor = UIColor.label
        errorLabel.textAlignment = .center

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
    }

    private func setupErrorIcon() {
        contentView.addSubview(errorIcon)

        errorIcon.image = UIImage(named: "errorIcon")?.withRenderingMode(.alwaysTemplate)
        errorIcon.tintColor = UIColor.label

        errorIcon.translatesAutoresizingMaskIntoConstraints = false
        errorIcon.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        errorIcon.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        errorIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
        errorIcon.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20.0).isActive = true
    }
}
