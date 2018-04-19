import Foundation
import UIKit

open class BaseAdapter<T>: NSObject {
    private(set) var items: [T] = []

    var isLoading: Bool = false

    func update(items: [T]) {
        self.items = items
    }
}

open class TableBaseAdapter<T>: BaseAdapter<T>, UITableViewDelegate, UITableViewDataSource {
    private(set) weak var tableView: UITableView?

    override var isLoading: Bool {
        didSet {
            tableView?.isUserInteractionEnabled = !isLoading
            tableView?.reloadData()
        }
    }

    override func update(items: [T]) {
        super.update(items: items)
        self.tableView?.reloadData()
    }

    open func attach(tableView: UITableView?) {
        self.tableView = tableView
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("tableView(tableView:section:) has not been implemented")
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("tableView(tableView:indexPath:) has not been implemented")
    }
}
