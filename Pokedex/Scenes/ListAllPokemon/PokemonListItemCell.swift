import UIKit
import Layout
import RxSwift

final class PokemonListItemCell: UICollectionViewCell {
    private(set) var disposeBag = DisposeBag()

    @objc var image: UIImageView!

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
