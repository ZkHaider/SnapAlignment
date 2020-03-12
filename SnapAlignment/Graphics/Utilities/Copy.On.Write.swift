//
//  Copy.On.Write.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

final class Ref<T> {
    
    // MARK: - Attributes
    
    internal var value: T
    
    // MARK: - Init
    
    init(value: T) {
        self.value = value
    }
    
}

public struct Box<T> {
    
    // MARK: - Ref
    
    private var ref: Ref<T>
    
    // MARK: - Value
    
    public var value: T {
        get {
            return self.ref.value
        }
        set {
            guard
                isKnownUniquelyReferenced(&self.ref)
                else {
                    self.ref = Ref(value: newValue)
                    return
            }
            ref.value = newValue
        }
    }
    
    // MARK: - Init
    
    public init(value: T) {
        self.ref = Ref(value: value)
    }
    
}
