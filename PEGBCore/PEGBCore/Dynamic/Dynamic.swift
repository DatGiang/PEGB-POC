//
//  Dynamic.swift
//  poc
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation

public class Dynamic<T> {
    public typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ val: T) {
        value = val
    }

    public func bind(listener: Listener?) {
        self.listener = listener
    }

    public func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
