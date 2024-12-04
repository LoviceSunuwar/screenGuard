//
//  ScreenshotOverlayView.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import UIKit

public class ScreenshotOverlayView: UIView {
    private let messageLabel: UILabel

    public override init(frame: CGRect) {
        messageLabel = UILabel()
        super.init(frame: frame)

        messageLabel.text = "Oops! Screenshot is not allowed."
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
