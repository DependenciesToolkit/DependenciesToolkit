import Cocoa

class MainViewController: NSViewController, StoryboardSceneBased {
    
    var viewModel: MainViewModel!
    
    @IBOutlet private var workspaceFilePathInput: NSTokenField!
    @IBOutlet private var projectFilePathInput: NSTokenField!
    
    @IBOutlet private weak var bitcodeButton: NSButton!
    @IBOutlet private weak var debugButton: NSButton!
    @IBOutlet private weak var releaseButton: NSButton!
    @IBOutlet private weak var buildButton: NSButton!
    @IBOutlet private weak var dependenciesTypeOverlayView: NSView! {
        didSet {
            dependenciesTypeOverlayView.wantsLayer = true
            dependenciesTypeOverlayView.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.8).cgColor
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private actions
private extension MainViewController {
    @IBAction func selectProjectButtonTapped(_ sender: Any) {
        selectFile(types: [ProjectExtension.project.rawValue]) { [unowned self] (urls) in
            let path = urls.first!.path
            self.projectFilePathInput.stringValue = path
            self.viewModel.didSelectFile(path, type: .project)
            // TODO: configure selection of configurations and dynamic configurations update
        }
    }
    
    @IBAction func selectWorkspaceButtonTapped(_ sender: Any) {
        selectFile(types: [ProjectExtension.workspace.rawValue]) { [unowned self] (urls) in
            let path = urls.first!.path
            self.workspaceFilePathInput.stringValue = path
            self.viewModel.didSelectFile(path, type: .workspace)
        }
    }
    
    @IBAction func debugButtonTapped(_ sender: NSButton) {
        handleConfigurationTap(sender)
    }
    
    @IBAction func releaseButtonTapped(_ sender: NSButton) {
        handleConfigurationTap(sender)
    }
    
    func handleConfigurationTap(_ sender: NSButton) {
        if debugButton.state == .off && releaseButton.state == .off {
            sender.state = .on
        }
    }
    
    @IBAction func bitcodeButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func buildButtonTapped(_ sender: Any) {
        viewModel.configurations()
        viewModel.targets()
        viewModel.schemes()
        viewModel.build(configuration: "Debug", target: "Dependencies")
    }
}

