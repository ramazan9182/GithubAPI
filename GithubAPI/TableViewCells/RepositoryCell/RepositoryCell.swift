//
//  RepositoryCell.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import UIKit

public class RepositoryCell: UITableViewCell {
    
    public static let identifier = "RepositoryCell"
    
    private lazy var repositoryTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        contentView.addSubview(leftStackView)
        setupLeftStackViewConstraint()
    }
    
    func setupLeftStackViewConstraint() {
        leftStackView.addArrangedSubview(repositoryTitleLabel)
        leftStackView.addArrangedSubview(repositoryDescriptionLabel)
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            leftStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

// MARK: - Configure
extension RepositoryCell {
    public func configure(item: RepositoryCell.Item) {
        let descriptionAtributedText = NSAttributedString (string: item.description.capitalizingFirstLetter(),
                                                           attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
                                                                        NSAttributedString.Key.foregroundColor : UIColor.gray])
        repositoryTitleLabel.text = item.name.capitalizingFirstLetter()
        repositoryDescriptionLabel.attributedText = descriptionAtributedText
    }
}
