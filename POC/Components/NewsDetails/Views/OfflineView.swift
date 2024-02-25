//
//  OfflineView.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUIKit
import UIKit

class OfflineView: UIView, View {
    private lazy var scrollView: PEGBUIScrollView = {
        let view = PEGBUIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var thumbnailImageView: PEGBUIAsyncImageView = {
        let view = PEGBUIAsyncImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .white
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = .white
        return view
    }()
    
    private lazy var timeStampImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "calendar")
        view.setHightlightColor(.white)
        return view
    }()

    private lazy var timeStampLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .white
        return view
    }()

    private lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = .left
        return view
    }()

    var viewModel: OfflineViewModel? {
        didSet {
            bindViewModel()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

extension OfflineView {
    private func setupViews() {
        setupScrollView()
        setupThumbnailImageView()
        setupTimestampLabel()
        setupTimeStampImageView()
        setupAuthorLabel()
        setupTitleLabel()
        setupContentLabel()
    }

    private func setupScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    private func setupThumbnailImageView() {
        scrollView.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: scrollView.topContentViewAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: scrollView.leadingContentViewAnchor),
            thumbnailImageView.centerXAnchor.constraint(equalTo: scrollView.centerXContentViewAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
        ])
    }

    private func setupAuthorLabel() {
        thumbnailImageView.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -UIConstants.Padding.medium),
            authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: UIConstants.Padding.medium),
            timeStampLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: UIConstants.Padding.big),
        ])
        timeStampLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        authorLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    private func setupTimestampLabel() {
        thumbnailImageView.addSubview(timeStampLabel)
        NSLayoutConstraint.activate([
            timeStampLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -UIConstants.Padding.medium),
            timeStampLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: -UIConstants.Padding.medium),
        ])
    }
    
    private func setupTimeStampImageView() {
        thumbnailImageView.addSubview(timeStampImageView)
        NSLayoutConstraint.activate([
            timeStampImageView.centerYAnchor.constraint(equalTo: timeStampLabel.centerYAnchor),
            timeStampImageView.heightAnchor.constraint(equalTo: timeStampImageView.widthAnchor),
            timeStampImageView.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.tinyIconSize.height),
            timeStampImageView.trailingAnchor.constraint(equalTo: timeStampLabel.leadingAnchor, constant: -UIConstants.Padding.small),
        ])
    }

    private func setupTitleLabel() {
        thumbnailImageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -UIConstants.Padding.medium),
            titleLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor),
        ])
    }

    private func setupContentLabel() {
        scrollView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: UIConstants.Padding.big),
            contentLabel.leadingAnchor.constraint(equalTo: scrollView.leadingContentViewAnchor, constant: UIConstants.Padding.medium),
            contentLabel.centerXAnchor.constraint(equalTo: scrollView.centerXContentViewAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomContentViewAnchor, constant: -UIConstants.Padding.big),
        ])
    }
}

extension OfflineView {
    private func bindViewModel() {
        viewModel?.news.bindAndFire { [weak self] in
            self?.authorLabel.text = $0.author ?? ""
            self?.titleLabel.text = $0.title ?? ""
            self?.timeStampLabel.text = $0.publishedAt?.to(other: .calendarFormat) ?? ""
            self?.contentLabel.text = $0.content
            if let urlToImage = $0.urlToImage,
               let urlImage = URL(string: urlToImage) {
                self?.thumbnailImageView.url = urlImage
            }
        }
    }
}
