import UIKit
import Layout
import RxSwift

final class EvolutionListItemCell: UICollectionViewCell {
    private(set) var disposeBag = DisposeBag()

    @objc var image: UIImageView!
    @objc var name: String!

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
