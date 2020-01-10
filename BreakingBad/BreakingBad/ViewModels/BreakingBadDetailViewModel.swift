//
//  BreakingBadDetailViewModel.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 10/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

class Observer<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
        
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}


protocol BreakingBadDetailViewModelUseCase {
  var character:Observer<Character> { get set }
}

final class BreakingBadDetailViewModel : BreakingBadDetailViewModelUseCase  {
  var character: Observer<Character> = Observer(Character.emptyCharacter)
}
