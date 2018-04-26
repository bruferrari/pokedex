import Foundation
import UIKit
import RxSwift
import Layout
import RxCocoa

final class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel> {
    @objc var closeButton: UIButton!
    @objc var pokemonImage: UIImageView!

    override var constants: LayoutConstants {
        var constants = super.constants
        constants["string.pokemonDetail.evolutions"] = R.string.pokemonDetail.pokemonDetailEvolutions()
        constants["string.pokemonDetail.resistant"] = R.string.pokemonDetail.pokemonDetailResistant()
        constants["string.pokemonDetail.weakness"] = R.string.pokemonDetail.pokemonDetailWeakness()
        return constants
    }

    override var initialViewState: ViewState {
        return ["state": PokemonDetailViewState.empty]
    }

    override func rebuildView() {
        bag << closeButton.rx.tap.bind(to: viewModel.input.close)

        bag << viewModel.output.viewState
            .drive(onNext: { [unowned self] state in
                self.layoutNode?.setState(["state": state])
            })

        bag << viewModel.output.viewState
            .drive(onNext: { [unowned self] state in
                self.pokemonImage.kf.setImage(with: URL(string: state.pokemon.image))
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(firstColor: UIColor(red: 0.92, green: 0.96, blue: 0.71, alpha: 1.0),
                                   secondColor: UIColor(red: 0.46, green: 0.79, blue: 0.81, alpha: 1.0))
    }
}
