import UIKit

enum Font {
    case body, footnote

    private var font: UIFont {
        switch self {
        case .body: return UIFont.preferredFont(forTextStyle: .body)
        case .footnote: return UIFont.preferredFont(forTextStyle: .footnote)
        }
    }

    static var layoutConstants: [String: Any] {
        return ["theme.font.body": Font.body.font,
                "theme.font.footnote": Font.footnote.font]
    }
}
