
import UIKit
import Tyler
import Variable
import Tag

public class RemoteTileViewController: UIViewController {

    public private(set) var context: Context!
    public private(set) var remoteTile: RemoteTile!
    public var tile: Tile! { return remoteTile.tile }
    public private(set) var pool: VariablePool
    public var tags: [Tag] = [.currentOrientation, .wildcard] {
        didSet {
            render()
        }
    }

    public var field: UITextField!

    private weak var tyler: Tyler!

    public init(remoteTile: RemoteTile, tyler: Tyler, pool: VariablePool = VariablePool()) {
        self.remoteTile = remoteTile
        self.tyler = tyler
        self.pool = pool
        super.init(nibName: nil, bundle: nil)
        self.remoteTile.success = { [weak self] tile in
            self?.render()
        }
        self.remoteTile.failure = { [weak self] error in
            print(error)
        }
        self.remoteTile.load()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private func render() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            guard let tile = self.tile else { return }
            self.context = self.tyler.tile(tile, in: self.view, pool: self.pool, tags: self.tags)
        }
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

    #if DEBUG
    public override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            remoteTile.load()
        }
    }
    #endif
}

public final class RemoteTile {

    public let url: URL
    public private(set) var tile: Tile!

    public var success: ((Tile) -> Void)?
    public var failure: ((Error?) -> Void)?

    public init(url: URL) {
        self.url = url
        self.tile = nil
    }

    @discardableResult
    fileprivate func load() -> URLSessionTask {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data else {
                self?.failure?(error)
                return
            }

            do {
                let tile = try JSONDecoder().decode(Tile.self, from: data)
                self?.tile = tile
                self?.success?(tile)
            } catch {
                self?.failure?(error)
            }
        }

        task.resume()
        return task
    }

}
