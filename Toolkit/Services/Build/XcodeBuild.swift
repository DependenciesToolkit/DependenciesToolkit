class XcodeBuild {
    
    private let terminal: Terminal
    
    init(terminal: Terminal) {
        self.terminal = terminal
    }
    
    func configurations(_ projectPath: String) -> Result<[String], XcodeBuildError> {
        var command = TerminalCommand("xcodebuild")
        command.append("-project \(projectPath)")
        command.append("-list")
        let result = terminal.execute(command: command)
        switch result {
        case let .success(response):
            let configurations = response.slice(from: "Build Configurations:", to: "\n\n")?
                .split(separator: String.space.toChar)
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { $0 != .empty }
                ?? []
            return Result.success(configurations)
        case let .failure(error):
            return Result.failure(XcodeBuildError())
        }
    }
    
    func schemes(_ projectPath: String) -> Result<[String], XcodeBuildError> {
        var command = TerminalCommand("xcodebuild")
        command.append("-project \(projectPath)")
        command.append("-list")
        let result = terminal.execute(command: command)
        switch result {
        case let .success(response):
            let targets = response.slice(from: "Schemes:", to: "\n\n")?
                .split(separator: String.space.toChar)
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { $0 != .empty }
                ?? []
            return Result.success(targets)
        case let .failure(error):
            return Result.failure(XcodeBuildError())
        }
    }
    
    func targets(_ projectPath: String) -> Result<[String], XcodeBuildError> {
        var command = TerminalCommand("xcodebuild")
        command.append("-project \(projectPath)")
        command.append("-list")
        let result = terminal.execute(command: command)
        switch result {
        case let .success(response):
            let targets = response.slice(from: "Targets:", to: "\n\n")?
                .split(separator: String.space.toChar)
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { $0 != .empty }
                ?? []
            return Result.success(targets)
        case let .failure(error):
            return Result.failure(XcodeBuildError())
        }
    }
    
    func build(_ project: SourceProjectKind, configuration: String, target: String) -> Result<Bool, XcodeBuildError> {
        build(configuration: configuration, sdk: .iphone, project: project, target: target, bitcode: false)
        return Result.success(true)
    }
    
    func archive() {
        
    }
}

private extension XcodeBuild {
    func build(configuration: String, sdk: SDK, project: SourceProjectKind, target: String, bitcode: Bool) {
        var command = TerminalCommand("xcodebuild")
        command.append("-configuration \(configuration)")
        command.append("-sdk \(sdk.rawValue)")
        command.append("-scheme \(target)")
        switch project {
        case let .project(path):
            command.append("-project \(path)")
        case let .workspace(path):
            command.append("-workspace \(path)")
        }
        command.append("-UseModernBuildSystem=NO")
        command.append("ONLY_ACTIVE_ARCH=NO")
        command.append("ENABLE_BITCODE=\(bitcode.objcValue)")
        command.append("CONFIGURATION_BUILD_DIR=/Users/s.molyak/Documents/projects/sportcast-ios-deps/Build")
        let result = terminal.execute(command: command)
        switch result {
        case let .success(response):
            print(response)
        case let .failure(error):
            print(error)
        }
    }
}
