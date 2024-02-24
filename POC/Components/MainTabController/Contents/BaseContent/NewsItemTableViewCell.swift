//
//  NewsItemTableViewCell.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit
import PEGBUIKit

class NewsItemTableViewCell: UITableViewCell {
    private lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorner(radius: 16)
        view.image = UIImage(named: "ic_thumb")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .lightGray
        view.text = "Kyung Lah"
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 12)
        view.text = "Governor Newsom Announces Statewide Expansion of CA Notify, a Smart Phone Tool Designed to Slow the Spread of COVID-19"
        return view
    }()
    
    private lazy var timeStampLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .lightGray
        view.text = "02 Oct, 2023"
        return view
    }()

    private lazy var bookmarkButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "bookmark.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
        fatalError("init(coder:) has not been implemented")
    }

    private func initViews() {
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
            backgroundViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupThumbnailImageView() {
        backgroundViewCell.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor, constant: UIConstants.Padding.small),
            thumbnailImageView.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: UIConstants.Padding.medium),
            thumbnailImageView.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.thumbnailSize.height)
        ])
    }

    private func setupTitleLabel() {
        backgroundViewCell.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: UIConstants.Padding.medium),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -UIConstants.Padding.medium)
        ])
    }
    
    private func setupAuthorLabel() {
        backgroundViewCell.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -UIConstants.Padding.small),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
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
            bookmarkButton.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor)
        ])
    }
}
