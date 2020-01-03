import Cocoa

class Terminal {
    func execute(command: TerminalCommand) -> Result<String, TerminalError> {
        let process = Process()
        process.launchPath = "/bin/sh"
        let arguments: [String] = ["-c", command.rawValue]
        process.arguments = arguments
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        
        var data = Data()
        outputPipe.fileHandleForReading.readabilityHandler = { handle in
            data += handle.availableData
        }
        
        process.launch()
        process.waitUntilExit()
        let status = process.terminationStatus
        if status == 0 {
            return Result.success(String(data: data, encoding: .utf8)!)
        } else {
            return Result.failure(TerminalError(status: status))
        }
    }
}
