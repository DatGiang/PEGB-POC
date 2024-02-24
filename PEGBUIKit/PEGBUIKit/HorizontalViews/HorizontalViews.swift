//
//  HorizontalViews.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit

open class HorizontalViews: UIView {
    public lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()

    private lazy var leadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var trailingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    public func addSubLeadingView(_ view: UIView) {
        leadingView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: leadingView.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingView.leadingAnchor),
            view.centerYAnchor.constraint(equalTo: leadingView.centerYAnchor),
        ])
    }

    public func addSubTrailingView(_ view: UIView) {
        trailingView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: trailingView.topAnchor),
            view.trailingAnchor.constraint(equalTo: trailingView.trailingAnchor),
            view.centerYAnchor.constraint(equalTo: trailingView.centerYAnchor),
        ])
    }
}

extension HorizontalViews {
    private func setupViews() {
        heightAnchor.constraint(equalToConstant: UIConstants.Sizes.navigationBarHeight).isActive = true
        setupTitleLabel()
        setupLeadingView()
        setupTrailingView()
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    private func setupLeadingView() {
        addSubview(leadingView)
        NSLayoutConstraint.activate([
            leadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }

    private func setupTrailingView() {
        addSubview(trailingView)
        NSLayoutConstraint.activate([
            trailingView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            trailingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
