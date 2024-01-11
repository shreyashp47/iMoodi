//
//  ToastMessageView.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 11/01/24.
//
import UIKit

class ToastMessageView: UILabel {

    // Function to show the toast message
    func showToast(message: String, duration: TimeInterval = 4.0) {
        self.text = message
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.alpha = 0.0
        self.layer.cornerRadius = 10
        self.clipsToBounds = true

        // Add the toast view to the top of the key window
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.addSubview(self)

            // Set constraints for the toast view
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
                self.bottomAnchor.constraint(equalTo: keyWindow.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])

            // Animate the appearance and disappearance of the toast message
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
                    self.alpha = 0.0
                }) { _ in
                    self.removeFromSuperview()
                }
            }
        }
    }
}
