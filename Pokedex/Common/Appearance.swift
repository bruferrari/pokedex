import UIKit

enum Font {
    case body, footnote, title1

    private var font: UIFont {
        switch self {
        case .body: return UIFont.preferredFont(forTextStyle: .body)
        case .footnote: return UIFont.preferredFont(forTextStyle: .footnote)
        case .title1: return UIFont.preferredFont(forTextStyle: .title1)
        }
    }

    static var layoutConstants: [String: Any] {
        return ["theme.font.body": Font.body.font,
                "theme.font.footnote": Font.footnote.font,
                "theme.font.title1": Font.title1.font]
    }
}
