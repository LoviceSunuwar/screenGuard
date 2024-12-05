//
//  ScreenshotOverlayView.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import UIKit

public class ScreenshotOverlayView: UIView {
    
    private var customView: UIView?
    
    // Initialize with an optional custom view
    public init(frame: CGRect, customView: UIView? = nil) {
        self.customView = customView
        super.init(frame: frame)
        
        // Set up the overlay background
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // If a custom view is passed, add it to the overlay
        if let customView = customView {
            addSubview(customView)
            
            // Center the custom view within the overlay
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.centerXAnchor.constraint(equalTo: centerXAnchor),
                customView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        } else {
            // Default behavior: Show a message if no custom view is passed
            let messageLabel = UILabel()
            messageLabel.text = "Oops! Screenshot is not allowed."
            messageLabel.textColor = .white
            messageLabel.textAlignment = .center
            addSubview(messageLabel)
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        // Add a tap gesture recognizer to detect taps anywhere in the overlay
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    // This is required by the NSCoder when initializing from storyboard (if used)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // Handle tap gesture and remove the overlay if tapped outside the custom view
    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        
        // Check if the tap is outside the custom view
        if let customView = customView {
            if !customView.frame.contains(location) {
                self.removeFromSuperview()
            }
        } else {
            // If no custom view is present, remove the overlay on any tap
            self.removeFromSuperview()
        }
    }

}
