import UIKit

enum Font {
    case body, footnote, title1, detailTitle, mainTitle

    private var font: UIFont {
        switch self {
        case .body: return UIFont.preferredFont(forTextStyle: .body)
        case .footnote: return UIFont.preferredFont(forTextStyle: .footnote)
        case .title1: return UIFont.preferredFont(forTextStyle: .title1)
        case .detailTitle: return UIFont.preferredFont(forTextStyle: .title2)
        case .mainTitle: return UIFont.preferredFont(forTextStyle: .title3)
        }
    }

    static var layoutConstants: [String: Any] {
        return ["theme.font.body": Font.body.font,
                "theme.font.footnote": Font.footnote.font,
                "theme.font.title1": Font.title1.font,
                "theme.font.detailTitle": Font.detailTitle.font,
                "theme.font.mainTitle": Font.title1.font]
    }
}
