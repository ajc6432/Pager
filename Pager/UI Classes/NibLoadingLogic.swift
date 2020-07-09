import Foundation

protocol HasReuseID {
    static var reuseID: String { get }
}

protocol Loadable: HasReuseID {
    static func loadFromNib() -> Self
}

extension Loadable {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed(reuseID, owner: nil, options: nil)?.first as! Self
    }
}
