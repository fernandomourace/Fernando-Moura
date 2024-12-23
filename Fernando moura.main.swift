import Foundation
import ArgumentParser

struct TextTool: ParsableCommand {
    @Argument(help: "Caminho do arquivo de texto.")
    var filePath: String

    @Option(name: .shortAndLong, help: "Palavra para buscar.")
    var search: String?

    @Option(name: .shortAndLong, help: "Palavra a ser substituída.")
    var replace: String?

    @Option(name: .shortAndLong, help: "Nova palavra.")
    var newWord: String?

    func run() throws {
        guard FileManager.default.fileExists(atPath: filePath) else {
            throw ValidationError("O arquivo especificado não existe.")
        }

        let content = try String(contentsOfFile: filePath, encoding: .utf8)

        if let searchTerm = search {
            let occurrences = content.components(separatedBy: searchTerm).count - 1
            print("A palavra '\(searchTerm)' aparece \(occurrences) vezes.")
        }

        if let replaceTerm = replace, let newTerm = newWord {
            let updatedContent = content.replacingOccurrences(of: replaceTerm, with: newTerm)
            try updatedContent.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("Substituição completa. A palavra '\(replaceTerm)' foi substituída por '\(newTerm)'.")
        }
    }
}

TextTool.main()
