import Foundation
import UIKit
import RxSwift
import RxCocoa

final class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel> {
    @objc var closeButton: UIButton!

    override func rebuildView() {
        bag << closeButton.rx.tap.bind(to: viewModel.input.close)
    }
}
