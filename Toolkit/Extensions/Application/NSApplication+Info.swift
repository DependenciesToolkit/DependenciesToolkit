import Cocoa

extension NSApplication {
    
    static var name: String {
        return read("CFBundleName")
    }
    
    static var version: String {
        let version = read("CFBundleShortVersionString")
        let build = read("CFBundleVersion")
        return version + " (" + build + ")"
    }
    
    private static func read(_ key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary, let value = infoDictionary[key] as? String else {
            assertionFailure("Info.plist does not contain the \(key)")
            return ""
        }
        
        return value
    }
}

