//
//  BreakingBadDetailViewModel.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 10/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol BreakingBadDetailViewModelUseCase {
  var character:Observer<Character> { get set }
}

final class BreakingBadDetailViewModel : BreakingBadDetailViewModelUseCase  {
  var character: Observer<Character> = Observer(Character.emptyCharacter)
}
