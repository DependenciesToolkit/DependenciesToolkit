import Cocoa

protocol StoryboardSceneBased: class {
    static var sceneStoryboard: NSStoryboard { get }
    static var sceneIdentifier: String { get }
}

extension StoryboardSceneBased {
    static var sceneIdentifier: String {
        return String(describing: self)
    }
}

extension StoryboardSceneBased where Self: NSViewController {
    static func instantiate() -> Self {
        let storyboard = sceneStoryboard
        guard let viewController = storyboard.instantiateController(withIdentifier: sceneIdentifier) as? Self else {
            fatalError("The viewController '\(sceneIdentifier)' of '\(storyboard)' is not of class '\(self)'")
        }
        return viewController
    }
}

extension StoryboardSceneBased {
    static var sceneStoryboard: NSStoryboard {
        let name = String(describing: self)
        let splitted = name
            .splitBefore(separator: { $0.isUpperCase })
            .map { String($0) }
        return NSStoryboard(name: splitted.first ?? "", bundle: nil)
    }
}
