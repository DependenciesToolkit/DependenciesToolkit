import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow {
        return NSApp.windows.first!
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.title = NSApplication.name
        window.minSize = CGSize(width: 678, height: 400)
        window.maxSize = CGSize(width: 678, height: 400)
        window.standardWindowButton(.zoomButton)?.isEnabled = false
        let closeButton = window.standardWindowButton(.closeButton)
        closeButton?.target = self
        closeButton?.action = #selector(closeDocumentButtonTapped)
        
        window.contentViewController = MainModule.create()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

// MARK: - Private actions
private extension AppDelegate {
    @objc func closeDocumentButtonTapped() {
        NSApp.terminate(nil)
    }
}
