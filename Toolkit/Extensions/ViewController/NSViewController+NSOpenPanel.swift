import Cocoa

extension NSViewController {
    typealias ModalResponseCompletionHandler = ([URL]) -> Void
    
    func selectFile(types: [String], completionHandler: @escaping ModalResponseCompletionHandler) {
        guard let window = view.window else { return }
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedFileTypes = types
        
        panel.beginSheetModal(for: window) { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                completionHandler(panel.urls)
            }
        }
    }
}
