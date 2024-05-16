//
//  RatingView.swift
//  JRNL
//
//  Created by mac on 5/16/24.
//

import UIKit

class RatingView: UIStackView {
    private var ratingButtons = [UIButton()]
    var rating = 0
    private let buttonSize = CGSize(width: 44.0, height: 44.0)
    private let buttonCount = 5
    
    // MARK: - Initialization
    required init(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    // MARK: - Private Methods
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        let filledStat = UIImage(systemName: "star.fill")
        let emtyStar = UIImage(systemName: "start")
        let highlightedStar = UIImage(systemName: "star.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        for _ in 0..<buttonCount {
            let button = UIButton()
            button.setImage(emtyStar, for: .normal)
            button.setImage(filledStat, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
}
