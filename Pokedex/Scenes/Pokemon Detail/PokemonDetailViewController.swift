import Foundation
import UIKit
import RxSwift
import Layout
import RxCocoa

final class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel>,
                                         UICollectionViewDelegateFlowLayout {
    fileprivate let itemsPerRow: CGFloat = 1

    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 50.0, bottom: 40, right: 50.0)

    @objc var closeButton: UIButton!
    @objc var pokemonImage: UIImageView!

    private let fastAttacksAdapter = AttacksAdapter()
    private let specialAttacksAdapter = AttacksAdapter()
    private let evolutionsAdapter = EvolutionsAdapter()

    @objc var fastAttacksCollectionView: UICollectionView!
    @objc var specialAttacksCollectionView: UICollectionView!
    @objc var evolutionsCollectionView: UICollectionView!
    @objc var activityIndicator: UIActivityIndicatorView!

    override var constants: LayoutConstants {
        var constants = super.constants
        constants["string.pokemonDetail.evolutions"] = R.string.pokemonDetail.pokemonDetailEvolutions()
        constants["string.pokemonDetail.resistant"] = R.string.pokemonDetail.pokemonDetailResistant()
        constants["string.pokemonDetail.weaknesess"] = R.string.pokemonDetail.pokemonDetailWeaknesess()
        constants["string.pokemonDetail.btnLabel"] = R.string.pokemonDetail.pokemonDetailBtnLabel()
        constants["string.pokemonDetail.type"] = R.string.pokemonDetail.pokemonDetailType()
        constants["string.pokemonDetail.height"] = R.string.pokemonDetail.pokemonDetailHeight()
        constants["string.pokemonDetail.weight"] = R.string.pokemonDetail.pokemonDetailWeight()
        constants["string.pokemonDetail.attacks"] = R.string.pokemonDetail.pokemonDetailAttacks()
        constants["string.pokemonDetail.fast"] = R.string.pokemonDetail.pokemonDetailFast()
        constants["string.pokemonDetail.special"] = R.string.pokemonDetail.pokemonDetailSpecial()

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

        fastAttacksAdapter.attach(collectionView: fastAttacksCollectionView)
        specialAttacksAdapter.attach(collectionView: specialAttacksCollectionView)
        evolutionsAdapter.attach(collectionView: evolutionsCollectionView)

        bag << viewModel.output.pokemon.drive(onNext: { [unowned self] pokemon in
            self.fastAttacksAdapter.update(items: pokemon.fastAttacks)
        })

        bag << viewModel.output.pokemon.drive(onNext: { [unowned self] pokemon in
            self.specialAttacksAdapter.update(items: pokemon.specialAttacks)
        })

        // TODO resolve evolutions problem
//        bag << viewModel.output.pokemon.drive(onNext: { [unowned self] pokemon in
//            self.evolutionsAdapter.update(items: pokemon.evolutions)
//        })

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(firstColor: UIColor(red: 0.92, green: 0.96, blue: 0.71, alpha: 1.0),
                                   secondColor: UIColor(red: 0.46, green: 0.79, blue: 0.81, alpha: 1.0))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
}
