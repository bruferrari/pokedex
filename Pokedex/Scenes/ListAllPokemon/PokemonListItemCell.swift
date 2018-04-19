//
//  PokemonListItemCell.swift
//  Pokedex
//
//  Created by Bruno Ferrari on 18/04/18.
//  Copyright © 2018 Ignus Digital. All rights reserved.
//

import UIKit
import Layout
import RxSwift

final class PokemonListItemCell: UITableViewCell {
    private(set) var disposeBag = DisposeBag()

    @objc var pokemonImage: UIImageView!

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
