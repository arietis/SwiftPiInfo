@main
public enum SwiftPiInfo {
  public static func main() {
    let usage = "Usage: swift run <executable_name> [--s, --version]"

    let arguments = CommandLine.arguments

    if arguments.count == 1 {
      print(RPIModel.model())
    } else if arguments.count == 2 {
      switch arguments[1] {
      case "--s":
        print(RPIModel.modelStrict())
      case "--version":
        print(RPIModel.version)
      default:
        print(usage)
      }
    } else {
      print(usage)
    }
  }
}
