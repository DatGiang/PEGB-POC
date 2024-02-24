//
//  OfflineView.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit

class OfflineView: UIView {
    private lazy var scrollView: PEGBUIScrollView = {
        let view = PEGBUIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ic_thumb")
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .white
        view.text = "Kyung Lah"
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Governor Newsom Announces Statewide Expansion of CA Notify, a Smart Phone Tool Designed to Slow the Spread of COVID-19"
        view.textColor = .white
        return view
    }()
    
    private lazy var timeStampLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .white
        view.text = "02 Oct, 2023"
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 14)
        view.text = "As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] As a Florida elementary school tries to contain a growing measles outbreak, the states top health official is giving advice that runs counter to science and may leave unvaccinated children at risk of… [+6871 chars] "
        view.textAlignment = .left
        return view
    }()

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
        setupAuthorLabel()
        setupTimestampLabel()
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
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupAuthorLabel() {
        thumbnailImageView.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -UIConstants.Padding.medium),
            authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: UIConstants.Padding.medium),
        ])
    }
    
    private func setupTimestampLabel() {
        thumbnailImageView.addSubview(timeStampLabel)
        NSLayoutConstraint.activate([
            timeStampLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -UIConstants.Padding.medium),
            timeStampLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: -UIConstants.Padding.medium),
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
