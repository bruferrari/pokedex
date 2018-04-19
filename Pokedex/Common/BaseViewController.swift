import RxSwift
import Layout

typealias ViewState = [String: Any]
typealias LayoutConstants = [String: Any]

protocol LayoutableController: LayoutLoading {
    var initialViewState: ViewState { get }
    var constants: LayoutConstants { get }

    func rebuildView()
}

class BaseViewController<T: RxViewModel>: UIViewController, ViewModelController, LayoutableController {
    private(set) var bag = DisposeBag()
    private(set) var viewModel: T

    required init(viewModel: T) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    convenience init(layoutName: String, viewModel: T) {
        self.init(viewModel: viewModel)

        loadLayout(named: layoutName, state: initialViewState, constants: constants)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }

    deinit {
        bag = DisposeBag()
    }

    var constants: LayoutConstants { return Font.layoutConstants }
    var initialViewState: ViewState { return [:] }
    func rebuildView() { }

    func layoutDidLoad(_ layoutNode: LayoutNode) {
        bag = DisposeBag()
        rebuildView()
    }
}
