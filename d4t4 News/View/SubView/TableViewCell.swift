//
//  TableViewCell.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    weak var delegate: CustomTableViewCellDelegate?
    let speechButton = UIButton(type: .system)
    let viewArticleButton = UIButton(type: .system)
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        speechButton.setTitle("Speech", for: .normal)
        viewArticleButton.setTitle("View", for: .normal)
        titleLabel.numberOfLines = 5
        
        // Button appearance
        configureButton(speechButton, backgroundColor: .systemBlue, titleColor: .white)
        configureButton(viewArticleButton, backgroundColor: .systemIndigo, titleColor: .white)
        
        speechButton.addTarget(self, action: #selector(speakTitle), for: .touchUpInside)
        
        // Layout
        let buttonsStackView = UIStackView(arrangedSubviews: [speechButton, viewArticleButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10

        let horizontalStackView = UIStackView(arrangedSubviews: [titleLabel, buttonsStackView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .center
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(horizontalStackView)

        // AutoLayout constraints
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            buttonsStackView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureButton(_ button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    @objc private func speakTitle() {
        if let title = titleLabel.text {
            delegate?.didTapSpeechButton(withText: title)
        }
    }
    
    func configure(with article: ArticleDetail) {
        titleLabel.text = article.title
    }
}
