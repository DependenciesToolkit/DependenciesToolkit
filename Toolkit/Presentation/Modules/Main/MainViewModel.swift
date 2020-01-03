import Cocoa

enum ProjectExtension: String, CaseIterable {
    case workspace = "xcworkspace"
    case project = "xcodeproj"
}

class MainViewModel: ViewModel {
    
    var viewState = ViewState()
    struct ViewState {
        var projectPath: String = ""
        var workspacePath: String = ""
    }
    
    private let service: BuildService
    private let mainQueue = DispatchQueue.main
    private let workerQueue = DispatchQueue(label: "main-view-model", qos: .userInitiated)
    
    init(service: BuildService) {
        self.service = service
    }
}

// MARK: - Public actions
extension MainViewModel {
    
    func configurations() {
        workerQueue.async {
            let result = self.service.configurations(projectPath: self.viewState.projectPath)
            switch result {
            case let .success(configurations):
                print("Configurations: ", configurations)
                if configurations.isEmpty {
                    // TODO: we have not found schemes in specified project/workspace
                } else {
                    // TODO: select main scheme
                }
            case let .failure(error):
                // TODO: handle error
                break
            }
        }
    }
    
    func targets() {
        workerQueue.async {
            let result = self.service.targets(projectPath: self.viewState.projectPath)
            switch result {
            case let .success(schemes):
                print("Targets: ", schemes)
                if schemes.isEmpty {
                    // TODO: we have not found schemes in specified project/workspace
                } else {
                    // TODO: select main scheme
                }
            case let .failure(error):
                // TODO: handle error
                break
            }
        }
    }
    
    func schemes() {
        workerQueue.async {
            let result = self.service.schemes(projectPath: self.viewState.projectPath)
            switch result {
            case let .success(schemes):
                print("Schemes: ", schemes)
                if schemes.isEmpty {
                    // TODO: we have not found schemes in specified project/workspace
                } else {
                    // TODO: select main scheme
                }
            case let .failure(error):
                // TODO: handle error
                break
            }
        }
    }
    
    func build(configuration: String, target: String) {
        let selectedConfigurations = ["Debug", "Release"]
        selectedConfigurations.forEach { configuration in
            workerQueue.async {
                let project = SourceProjectKind.workspace(path: self.viewState.workspacePath)
                let result = self.service.build(project, configuration: configuration, target: target)
                switch result {
                case let .success(response):
                    print("Response: ", response)
                case let .failure(error):
                    // TODO: handle error
                    break
                }
            }
        }
    }
    
    func didSelectFile(_ path: String, type: ProjectExtension) {
        switch type {
        case .project:
            viewState.projectPath = path
        case .workspace:
            viewState.workspacePath = path
        }
    }
}
