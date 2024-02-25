//
//  NewsItemTableViewCell.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUIKit
import UIKit

class NewsItemTableViewCell: UITableViewCell, View {
    private lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var thumbnailImageView: PEGBUIAsyncImageView = {
        let view = PEGBUIAsyncImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorner(radius: 16)
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .lightGray
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()

    private lazy var timeStampLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .lightGray
        return view
    }()

    private lazy var bookmarkButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
        return view
    }()

    var viewModel: NewsItemTableViewCellViewModel? {
        didSet {
            bindViewModel()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapBookmark() {
        viewModel?.onTapBookmark()
    }
}

extension NewsItemTableViewCell {
    private func setupViews() {
        setupBackgroundView()
        setupThumbnailImageView()
        setupTitleLabel()
        setupAuthorLabel()
        setupTimestampLabel()
        setupBookmarkButton()
    }

    private func setupBackgroundView() {
        contentView.addSubview(backgroundViewCell)

        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundViewCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    private func setupThumbnailImageView() {
        backgroundViewCell.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor, constant: UIConstants.Padding.small),
            thumbnailImageView.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: UIConstants.Padding.medium),
            thumbnailImageView.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.thumbnailSize.height),
        ])
    }

    private func setupTitleLabel() {
        backgroundViewCell.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: UIConstants.Padding.medium),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -UIConstants.Padding.medium),
        ])
    }

    private func setupAuthorLabel() {
        backgroundViewCell.addSubview(authorLabel)

        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -UIConstants.Padding.small),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }

    private func setupTimestampLabel() {
        backgroundViewCell.addSubview(timeStampLabel)

        NSLayoutConstraint.activate([
            timeStampLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor),
            timeStampLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }

    private func setupBookmarkButton() {
        backgroundViewCell.addSubview(bookmarkButton)

        NSLayoutConstraint.activate([
            bookmarkButton.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -UIConstants.Padding.medium),
            bookmarkButton.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor),
        ])
    }
}

extension NewsItemTableViewCell {
    private func bindViewModel() {
        viewModel?.news.bindAndFire { [weak self] in
            self?.authorLabel.text = $0.author ?? ""
            self?.titleLabel.text = $0.title ?? ""
            self?.timeStampLabel.text = $0.publishedAt ?? ""
            if let urlToImage = $0.urlToImage,
               let urlImage = URL(string: urlToImage) {
                self?.thumbnailImageView.url = urlImage
            }
        }
    }
}
