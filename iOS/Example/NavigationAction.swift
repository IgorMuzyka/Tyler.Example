
import Action
import TypePreservingCodingAdapter

public struct NavigationAction: Action {

    public var destination: String

    public static var alias: Alias = "NavigationAction"
}
