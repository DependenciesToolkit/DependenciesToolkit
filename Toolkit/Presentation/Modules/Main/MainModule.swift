class MainModule {
    static func create() -> MainViewController {
        let viewController = MainViewController.instantiate()
        let xcodeBuild = XcodeBuild(terminal: Terminal())
        let buildService = BuildService(xcodebuild: xcodeBuild)
        viewController.viewModel = MainViewModel(service: buildService)
        return viewController
    }
}
