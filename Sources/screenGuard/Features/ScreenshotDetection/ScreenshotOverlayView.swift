import UIKit

public class ScreenshotOverlayView: UIView {
    private var customView: UIView?

    public init(frame: CGRect, customView: UIView? = nil) {
        self.customView = customView
        super.init(frame: frame)

        // Background dimming for the overlay
        backgroundColor = UIColor.black.withAlphaComponent(0.7)

        if let customView = customView {
            // Add the custom view to the overlay
            addSubview(customView)

            // Center the custom view within the overlay
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.centerXAnchor.constraint(equalTo: centerXAnchor),
                customView.centerYAnchor.constraint(equalTo: centerYAnchor),
                customView.widthAnchor.constraint(equalToConstant: customView.frame.width),
                customView.heightAnchor.constraint(equalToConstant: customView.frame.height)
            ])
        }

        // Add a tap gesture recognizer to dismiss the overlay and custom view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        // Remove the overlay and the custom view when tapped outside the custom view
        guard let customView = customView else {
            removeFromSuperview()
            return
        }
        let location = sender.location(in: self)
        if !customView.frame.contains(location) {
            customView.removeFromSuperview() // Remove the custom view
            removeFromSuperview()           // Remove the overlay
        }
    }
}
