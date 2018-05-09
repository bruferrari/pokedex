import UIKit

enum Font {
    case body, footnote, title1, detailTitle, mainTitle

    private var font: UIFont {
        switch self {
        case .body: return UIFont.preferredFont(forTextStyle: .body)
        case .footnote: return UIFont.preferredFont(forTextStyle: .footnote)
        case .title1: return UIFont.preferredFont(forTextStyle: .title1)
        case .detailTitle: return UIFont.preferredFont(forTextStyle: .title1).withSize(28)
        case .mainTitle: return UIFont.preferredFont(forTextStyle: .title1).withSize(34)
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

extension UIFont {
    func withTraits(traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)

        //size 0 means keep the size as it is
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func withSize(size: CGFloat = 0) -> UIFont {
        let descriptor = fontDescriptor.withSize(size)

        return UIFont(descriptor: descriptor, size: size)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
