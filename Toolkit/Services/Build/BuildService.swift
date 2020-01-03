
class BuildService {
    
    private let xcodebuild: XcodeBuild
    
    init(xcodebuild: XcodeBuild) {
        self.xcodebuild = xcodebuild
    }
}

// MARK: - Public actions
extension BuildService {
    
    func configurations(projectPath path: String) -> Result<[String], XcodeBuildError> {
        return xcodebuild.configurations(path)
    }
    
    func targets(projectPath path: String) -> Result<[String], XcodeBuildError> {
        return xcodebuild.targets(path)
    }
    
    func schemes(projectPath path: String) -> Result<[String], XcodeBuildError> {
        return xcodebuild.schemes(path)
    }
    
    func build(_ project: SourceProjectKind, configuration: String, target: String) -> Result<Bool, XcodeBuildError> {
        return xcodebuild.build(project, configuration: configuration, target: target)
    }
}
