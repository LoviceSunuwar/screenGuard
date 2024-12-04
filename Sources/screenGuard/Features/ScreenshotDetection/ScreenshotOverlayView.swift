//
//  ScreenshotOverlayView.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import UIKit

public class ScreenshotOverlayView: UIView {

    // This will hold the custom view passed by the developer
    private var customView: UIView?
    
    // Init method to accept a custom view
    public init(frame: CGRect, customView: UIView? = nil) {
        self.customView = customView
        super.init(frame: frame)
        
        // Set up the overlay background
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // If a custom view is passed, add it
        if let customView = customView {
            addSubview(customView)
            
            // Set up custom view constraints (center the view)
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.centerXAnchor.constraint(equalTo: centerXAnchor),
                customView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        } else {
            // Default behavior: Show a message if no custom view is passed
            let messageLabel = UILabel()
            messageLabel.text = "Default Behaviour"
            messageLabel.textColor = .white
            messageLabel.textAlignment = .center
            addSubview(messageLabel)
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        // Add a tap gesture recognizer to detect taps outside the custom view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    // This is required by the NSCoder when initializing from storyboard (if used)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Handle tap gesture and remove the overlay if tapped outside custom view
    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        // Check if the tap was outside the custom view
        if let customView = customView {
            let location = sender.location(in: self)
            if !customView.frame.contains(location) {
                // If tap is outside, remove the overlay from its superview
                self.removeFromSuperview()
            }
        }
    }
}
