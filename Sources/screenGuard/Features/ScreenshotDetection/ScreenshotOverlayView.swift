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
    @objc func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        // Get the location of the tap relative to the ScreenshotOverlayView instance (self)
        let location = sender.location(in: self)
        
        // Print the location of the tap to debug
        print("Tap Location: \(location)")
        
        // If the tap is outside the custom view, remove the overlay
        // Check if the location is outside of the customView's frame
        if let customView = customView, !customView.frame.contains(location) {
            print("Tapped outside the custom view. Removing overlay.")
            self.removeFromSuperview() // Remove the overlay view from superview
        } else {
            print("Tapped inside the custom view.")
        }
    }
}
