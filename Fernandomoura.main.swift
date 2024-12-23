import Foundation
import ArgumentParser

struct TextTool: ParsableCommand {
    @Argument(help: "Caminho do arquivo de texto.")
    var filePath: String

    @Flag(name: .shortAndLong, help: "Exibir a contagem de palavras no arquivo.")
    var countWords: Bool = false

    @Option(name: .shortAndLong, help: "Palavra para buscar.")
    var search: String?

    @Option(name: .shortAndLong, help: "Palavra a ser substituída.")
    var replace: String?

    @Option(name: .shortAndLong, help: "Nova palavra para substituição.")
    var newWord: String?

    func run() throws {
        // Verifica se o arquivo existe
        guard FileManager.default.fileExists(atPath: filePath) else {
            throw ValidationError("O arquivo especificado não existe.")
        }

        // Lê o conteúdo do arquivo
        let content = try String(contentsOfFile: filePath, encoding: .utf8)

        // Contagem de palavras
        if countWords {
            let wordCount = content.split { !$0.isLetter }.count
            print("O arquivo contém
