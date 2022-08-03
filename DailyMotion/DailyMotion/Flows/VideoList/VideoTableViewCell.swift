//
//  VideoTableViewCell.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

final class VideoTableViewCell: UITableViewCell {

    private let thumbnailImageView = UIImageView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        return label
    }()

    private let createdLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.minimumScaleFactor = 0.7
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, createdLabel])
        labelsStackView.spacing = Spacing.small
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading

        let mainStackView = UIStackView(arrangedSubviews: [thumbnailImageView, labelsStackView])
        mainStackView.spacing = Spacing.medium
        mainStackView.axis = .vertical

        addSubview(mainStackView, filling: self, insets: .init(top: Spacing.medium, leading: Spacing.medium, bottom: -Spacing.medium, trailing: -Spacing.medium))

        thumbnailImageView.backgroundColor = .lightGray
        thumbnailImageView.layer.cornerRadius = Spacing.small
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
    }

    func render(title: String, description: String, createdAt: String) {
        thumbnailImageView.image = nil
        titleLabel.text = title
        descriptionLabel.text = description.htmlToString
        createdLabel.text = createdAt
    }

    func setImage(image: UIImage) {
        thumbnailImageView.image = image
    }
}
