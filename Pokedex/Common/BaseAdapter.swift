import Foundation
import UIKit

open class BaseAdapter<T>: NSObject {
    private(set) var items: [T] = []

    var isLoading: Bool = false

    func update(items: [T]) {
        self.items = items
    }
}

open class TableBaseAdapter<T>: BaseAdapter<T>,
                                UICollectionViewDelegate,
                                UICollectionViewDataSource {

    private(set) weak var collectionView: UICollectionView?

    override var isLoading: Bool {
        didSet {
            collectionView?.isUserInteractionEnabled = !isLoading
            collectionView?.reloadData()
        }
    }

    override func update(items: [T]) {
        super.update(items: items)
        self.collectionView?.reloadData()
    }

    open func attach(collectionView: UICollectionView?) {
        self.collectionView = collectionView
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return isLoading ? collectionView.estimatedNumberOfRows : items.count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("collectionView(collectionView:indexPath:) has not been implemented")
    }
}

extension UICollectionView {
    var estimatedNumberOfRows: Int {
        guard let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        return Int(ceil(frame.height/flowlayout.itemSize.height))
    }
}
