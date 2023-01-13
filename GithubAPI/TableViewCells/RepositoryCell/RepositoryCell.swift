//
//  RepositoryCell.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import UIKit

public class RepositoryCell: UITableViewCell {
    
    public static let identifier = "RepositoryCell"
    private let spacingOfVerticalStackView: CGFloat = 4
    private let spacingOfHorizontalStackView: CGFloat = 4
    private let heightOfContainerOfImageView: CGFloat = 16
    private let topPaddingOfImageView: CGFloat = 4
    private let heightOfImageView: CGFloat = 12
    private let widthOfImageView: CGFloat = 12
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = spacingOfVerticalStackView
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = spacingOfHorizontalStackView
        return stackView
    }()
    
    private lazy var repositoryTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var favoriteCountLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var openIssuesCountLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var updatedDateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var containerOfImageView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var favoriteCountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}

// MARK: - setup (design, layout)
extension RepositoryCell {
    private func setup() {
        design()
        layout()
    }
    
    private func design() {
        backgroundColor = .white
    }
    
    private func layout() {
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        verticalStackView.addArrangedSubview(repositoryTitleLabel)
        verticalStackView.addArrangedSubview(repositoryDescriptionLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leftAnchor.constraint(equalTo: verticalStackView.leftAnchor),
            horizontalStackView.rightAnchor.constraint(equalTo: verticalStackView.rightAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: verticalStackView.topAnchor)
        ])
        
        containerOfImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerOfImageView.heightAnchor.constraint(equalToConstant: heightOfContainerOfImageView),
            containerOfImageView.widthAnchor.constraint(equalToConstant: widthOfImageView)
        ])
        
        favoriteCountImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteCountImageView.leftAnchor.constraint(equalTo: containerOfImageView.leftAnchor),
            favoriteCountImageView.topAnchor.constraint(equalTo: containerOfImageView.topAnchor, constant: topPaddingOfImageView),
            favoriteCountImageView.heightAnchor.constraint(equalToConstant: heightOfImageView),
            favoriteCountImageView.widthAnchor.constraint(equalToConstant: widthOfImageView)
        ])
        
        horizontalStackView.addArrangedSubview(favoriteCountImageView)
        horizontalStackView.addArrangedSubview(favoriteCountLabel)
        horizontalStackView.addArrangedSubview(languageLabel)
        horizontalStackView.addArrangedSubview(openIssuesCountLabel)
        horizontalStackView.addArrangedSubview(updatedDateLabel)
    }
}

// MARK: - Configure
extension RepositoryCell {
    public func configure(item: RepositoryCell.Item) {
        repositoryTitleLabel.text = item.name
        repositoryDescriptionLabel.text = item.description
        favoriteCountImageView.image = .add
        favoriteCountLabel.text = item.favoriteCount
        languageLabel.text = item.language
        openIssuesCountLabel.text = item.openIssuesCount
        updatedDateLabel.text = item.updatedDate
    }
}
