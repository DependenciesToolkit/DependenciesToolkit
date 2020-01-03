struct TerminalCommand {
    
    var rawValue: String {
        return rawCommand.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\t", with: " ")
    }
    
    private var rawCommand: String
    
    init(_ binary: String) {
        rawCommand = binary
    }
    
    mutating func append(_ command: String) {
        rawCommand += " \(command)"
    }
}
