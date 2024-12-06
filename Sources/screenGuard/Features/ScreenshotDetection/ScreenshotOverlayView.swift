import UIKit

public class ScreenshotOverlayView: UIView {
    
    private var customView: UIView?

    // Initialize with an optional custom view
    public init(frame: CGRect, customView: UIView? = nil) {
        self.customView = customView
        super.init(frame: frame)

        // Set up the overlay background
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // Add tap gesture recognizer to handle dismiss on tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView(_:)))
        addGestureRecognizer(tapGesture)
        
        // Add the custom view or a default message
        if let customView = customView {
            addSubview(customView)
            
            // Center the custom view within the overlay
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.centerXAnchor.constraint(equalTo: centerXAnchor),
                customView.centerYAnchor.constraint(equalTo: centerYAnchor),
                customView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.9), // Optional: Adjust size
                customView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.5) // Optional: Adjust size
            ])
        } else {
            // Default behavior: Show a message if no custom view is passed
            let messageLabel = UILabel()
            messageLabel.text = "Add in your custom view."
            messageLabel.textColor = .white
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            addSubview(messageLabel)
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8)
            ])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Handles tap gesture to dismiss the overlay when tapped outside the custom view.
    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self)
        
        // If the tap is outside the custom view, remove the overlay
        if let customView = customView, !customView.frame.contains(tapLocation) {
            self.removeFromSuperview()
        }
    }
}
