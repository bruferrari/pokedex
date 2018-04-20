import Foundation
import UIKit
import RxSwift
import RxCocoa

final class ListPokemonViewController: BaseViewController<ListPokemonViewModel>,
                            UICollectionViewDelegateFlowLayout {

    fileprivate let itemsPerRow: CGFloat = 2

    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0)

    private let adapter = PokemonsAdapter()

    @objc var collectionView: UICollectionView!
    @objc var activityIndicator: UIActivityIndicatorView!

    override func rebuildView() {
        adapter.attach(collectionView: collectionView)

        bag << [
            viewModel.output.isLoading.drive(activityIndicator.rx.isAnimating),
            viewModel.output.pokemon.drive(adapter.rx.updateItems),
            adapter.rx.itemSelected.bind(to: viewModel.input.selectPokemon)
        ]
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

            return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
//
//    private func generateGradient() -> CAGradientLayer {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
//
//        return gradientLayer
//    }
}
