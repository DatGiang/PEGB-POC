//
//  PEGBUIScrollView.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit

public class PEGBUIScrollView: UIScrollView {
    private lazy var scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    public var topContentViewAnchor: NSLayoutYAxisAnchor        { scrollViewContentView.topAnchor }
    public var leadingContentViewAnchor: NSLayoutXAxisAnchor    { scrollViewContentView.leadingAnchor }
    public var trailingContentViewAnchor: NSLayoutXAxisAnchor   { scrollViewContentView.trailingAnchor }
    public var centerXContentViewAnchor: NSLayoutXAxisAnchor    { scrollViewContentView.centerXAnchor }
    public var bottomContentViewAnchor: NSLayoutYAxisAnchor     { scrollViewContentView.bottomAnchor }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    override public func addSubview(_ view: UIView) {
        scrollViewContentView.addSubview(view)
    }
}

extension PEGBUIScrollView {
    private func setupViews() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        setupScrollViewContentView()
    }

    private func setupScrollViewContentView() {
        super.addSubview(scrollViewContentView)

        NSLayoutConstraint.activate([
            scrollViewContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollViewContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollViewContentView.topAnchor.constraint(equalTo: topAnchor),
            scrollViewContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollViewContentView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
