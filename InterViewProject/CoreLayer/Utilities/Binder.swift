//
//  Binder.swift
//  InterViewProject
//
//  Created by Abdullah Okudan on 5.05.2022.
//

//https://blog.devgenius.io/reactive-mvvm-pattern-in-uikit-30dde1574b6b

import Foundation
class Binder<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet { fireListenerOnMainThread() }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        fireListenerOnMainThread()
    }
    
    private func fireListenerOnMainThread() {
        DispatchQueue.main.async { [weak self] in
            guard let gSelf = self,
            let gListener = gSelf.listener else { return }
            gListener(gSelf.value)
        }
    }
}
