
/// Pretty much self explanatory
public enum Orientation: StringLiteralType {

    case horizontal
    case vertical
}

extension Orientation {

    public var opposite: Orientation {
        switch self {
        case .horizontal:
            return .vertical
        case .vertical:
            return .horizontal
        }
    }
}

