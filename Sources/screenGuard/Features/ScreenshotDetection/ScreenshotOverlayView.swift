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
        } else {
            // Show a default alert if no custom view is provided
            showAlert()
        }

        // Add a tap gesture recognizer to dismiss the overlay
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        // Remove the overlay when tapped outside the custom view
        guard let customView = customView else { return }
        let location = sender.location(in: self)
        if !customView.frame.contains(location) {
            removeFromSuperview()
        }
    }

    private func showAlert() {
        // Create an alert controller
        let alertController = UIAlertController(
            title: "Notice",
            message: "Add your custom implementation here.",
            preferredStyle: .alert
        )

        // Add an OK button to dismiss the overlay
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.removeFromSuperview()
        }
        alertController.addAction(okAction)

        // Find the topmost view controller to present the alert
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            var presentedController = topController
            while let presented = presentedController.presentedViewController {
                presentedController = presented
            }
            presentedController.present(alertController, animated: true, completion: nil)
        }
    }
}
