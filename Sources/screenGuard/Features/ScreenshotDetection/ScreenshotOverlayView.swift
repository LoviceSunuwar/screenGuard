// ScreenshotOverlayView.swift
import UIKit

public class ScreenshotOverlayView: UIView {
    public enum Position {
        case top
        case center
        case bottom
    }

    private var customView: UIView?
    private var position: Position

    // Initialization with a frame, custom view, and position
    public init(frame: CGRect, customView: UIView, position: Position = .center) {
        self.customView = customView
        self.position = position
        super.init(frame: frame)

        // Background dimming for the overlay
        backgroundColor = UIColor.black.withAlphaComponent(0.7)

        // Add the custom view
        addSubview(customView)
        setupConstraints(for: position)

        // Add a tap gesture recognizer to dismiss the overlay
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Function to set up the constraints based on the position
    private func setupConstraints(for position: Position) {
        guard let customView = customView else { return }
        customView.translatesAutoresizingMaskIntoConstraints = false

        // Common constraints for leading, trailing, and height
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customView.heightAnchor.constraint(equalToConstant: customView.frame.height)
        ])

        // Position-specific constraints
        switch position {
        case .top:
            NSLayoutConstraint.activate([
                customView.topAnchor.constraint(equalTo: topAnchor)
            ])
        case .center:
            NSLayoutConstraint.activate([
                customView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                customView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }

    // Function to dismiss the overlay when tapping outside of the custom view
    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        guard let customView = customView else { return }
        let location = sender.location(in: self)
        if !customView.frame.contains(location) {
            removeFromSuperview()
        }
    }
}
