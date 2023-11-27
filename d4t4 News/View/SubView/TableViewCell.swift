//
//  TableViewCell.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    weak var delegate: CustomTableViewCellDelegate?
    let speechButton = UIButton(type: .system)
    let viewArticleButton = UIButton(type: .system)
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    private var articleURL: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
   
        // DateLabel
        dateLabel.numberOfLines = 1
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .gray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        titleLabel.numberOfLines = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)

        // SpeechButton
        speechButton.setTitle("Speech", for: .normal)
        speechButton.addTarget(self, action: #selector(speakTitle), for: .touchUpInside)
        configureButton(speechButton, backgroundColor: .systemBlue, titleColor: .white)

        // ViewArticleButton
        viewArticleButton.setTitle("View", for: .normal)
        viewArticleButton.addTarget(self, action: #selector(viewArticle), for: .touchUpInside)
        configureButton(viewArticleButton, backgroundColor: .systemIndigo, titleColor: .white)

        // StackView for buttons
        let buttonsStackView = UIStackView(arrangedSubviews: [speechButton, viewArticleButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonsStackView)

        // Layout for cell
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            buttonsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 100),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func configureButton(_ button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    func configure(with article: ArticleDetail) {
        if let publishedAt = article.publishedAt {
            dateLabel.text = formatDateString(publishedAt)
        }
        titleLabel.text = article.title
        articleURL = article.url
    }

    @objc private func speakTitle() {
        if let title = titleLabel.text {
            delegate?.didTapSpeechButton(withText: title)
        }
    }

    @objc private func viewArticle() {
        if let url = articleURL {
            delegate?.didTapViewButton(withURL: url)
        }
    }
    
    private func formatDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" 
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        } else {
            return dateString
        }
    }

}
