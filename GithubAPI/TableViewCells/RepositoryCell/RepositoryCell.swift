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
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var favoriteCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var languageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var repositoryTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private lazy var repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
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
    
    private lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private lazy var languageView: UIView = {
        let view = UIView()
        view.backgroundColor = .red

        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
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
        setVerticalStackView()
        verticalStackView.addArrangedSubview(repositoryTitleLabel)
        verticalStackView.addArrangedSubview(repositoryDescriptionLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(favoriteCountStackView)
        horizontalStackView.addArrangedSubview(languageStackView)
        horizontalStackView.addArrangedSubview(openIssuesCountLabel)
        horizontalStackView.addArrangedSubview(updatedDateLabel)
        
        setFavoriteImageView()
        favoriteCountStackView.addArrangedSubview(favoriteImageView)
        favoriteCountStackView.addArrangedSubview(favoriteCountLabel)
        
        setLanguageView()
        languageStackView.addArrangedSubview(languageView)
        languageStackView.addArrangedSubview(languageLabel)
    }
    
    func setVerticalStackView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    func setFavoriteImageView() {
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        favoriteImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    func setLanguageView() {
        languageView.translatesAutoresizingMaskIntoConstraints = false
        languageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        languageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
}

// MARK: - Configure
extension RepositoryCell {
    public func configure(item: RepositoryCell.Item) {
        repositoryTitleLabel.text = item.name
        repositoryDescriptionLabel.text = item.description
        favoriteCountLabel.text = item.favoriteCount
        languageLabel.text = item.language
        openIssuesCountLabel.text = item.openIssuesCount
        updatedDateLabel.text = item.updatedDate
    }
}
