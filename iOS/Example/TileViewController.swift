
import UIKit
import Tyler
import Variable
import Tag

public class TileViewController: UIViewController {

    public private(set) var context: Context!
    public private(set) var tile: Tile
    public private(set) var pool = VariablePool()
    public var tags: [Tag] = [.currentOrientation, .wildcard] {
        didSet {
            render()
        }
    }

    public var field: UITextField!

    private weak var tyler: Tyler!

    public init(tile: Tile, tyler: Tyler) {
        self.tile = tile
        self.tyler = tyler
        super.init(nibName: nil, bundle: nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private func render() {
        context = tyler.tile(tile, in: view, pool: pool, tags: tags)
    }

    public override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch fromInterfaceOrientation {
        case .landscapeLeft, .landscapeRight: tags = [.landscape, .wildcard]
        case .portrait, .portraitUpsideDown: tags = [.portrait, .wildcard]
        case .unknown: break
        }
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("unavailable")
    }
}
