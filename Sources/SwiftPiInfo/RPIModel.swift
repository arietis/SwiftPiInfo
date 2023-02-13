
import Foundation

let modelA = ["0007", "0008", "0009"]

let modelB = ["0002", "0004", "0005", "0006", "000d", "000e", "000e", "000f"]

let modelBBeta = ["Beta"]

let modelBECN0001 = ["0003"]

let modelCM = ["0011", "0014"]

let modelCM3 = ["a020a0"]

let modelCM3Plus = ["a02100"]

let modelAPlus = ["0012", "0015", "900021"]

let modelBPlus = ["0010", "0013", "900032"]

let model2B = ["a01040", "a01041", "a21041"]

let model2B2837 = ["a22042"]

let model3B = ["a02082", "a22082", "a32082"]

let model3APlus = ["9020e0"]

let model3BPlus = ["a020d3"]

let model4B = [
  "a03111",
  "b03111",
  "b03112",
  "b03114",
  "c03111",
  "c03112",
  "c03114",
  "c03115",
  "d03114",
]

let modelZero = ["900092", "900093", "920093"]

let modelZeroW = ["9000c1"]

let modelZero2W = ["902120"]

enum RPIModel {
  static let version = "0.0.1"

  static func revision() -> String? {
    do {
      let cpuinfo = try String(contentsOfFile: "/proc/cpuinfo")

      let regex = try NSRegularExpression(pattern: "Revision.*: ([0123456789abcdef]*)", options: [])

      let matches = regex.matches(
        in: cpuinfo,
        options: [],
        range: NSRange(location: .zero, length: cpuinfo.utf16.count)
      )
      if let match = matches.first {
        let range = match.range(at: 1)

        if let swiftRange = Range(range, in: cpuinfo) { return String(cpuinfo[swiftRange]) }
      }
    } catch { return nil }

    return nil
  }

  static func modelStrict() -> String {
    guard let rev = revision() else { return "unknown" }

    switch rev {
    case let r where modelA.contains(r):
      return "A"
    case let r where modelB.contains(r):
      return "B"
    case let r where modelBBeta.contains(r):
      return "B (Beta)"
    case let r where modelBECN0001.contains(r):
      return "B (ECN0001)"
    case let r where modelCM.contains(r):
      return "Compute Module"
    case let r where modelCM3.contains(r):
      return "Compute Module 3 (and CM3 Lite)"
    case let r where modelCM3Plus.contains(r):
      return "Compute Module 3+"
    case let r where modelAPlus.contains(r):
      return "A+"
    case let r where modelBPlus.contains(r):
      return "B+"
    case let r where model2B.contains(r):
      return "2 Model B"
    case let r where model2B2837.contains(r):
      return "2 Model B (with BCM2837)"
    case let r where model3B.contains(r):
      return "3 Model B"
    case let r where model3APlus.contains(r):
      return "3 Model A+"
    case let r where model3BPlus.contains(r):
      return "3 Model B+"
    case let r where model4B.contains(r):
      return "4 Model B"
    case let r where modelZero.contains(r):
      return "Zero"
    case let r where modelZeroW.contains(r):
      return "Zero W"
    case let r where modelZero2W.contains(r):
      return "Zero 2 W"
    default:
      return rev
    }
  }

  static func model() -> String {
    guard let rev = revision() else { return "Unknown" }

    if modelA.contains(rev) {
      return "A"
    } else if modelB.contains(rev) || modelBBeta.contains(rev) || modelBECN0001.contains(rev) {
      return "B"
    } else if modelCM.contains(rev) || modelCM3.contains(rev) || modelCM3Plus.contains(rev) {
      return "Compute Module"
    } else if modelAPlus.contains(rev) {
      return "A+"
    } else if modelBPlus.contains(rev) {
      return "B+"
    } else if model2B.contains(rev) || model2B2837.contains(rev) {
      return "2 Model B"
    } else if model3APlus.contains(rev) {
      return "3 Model A"
    } else if model3B.contains(rev) || model3BPlus.contains(rev) {
      return "3 Model B"
    } else if model4B.contains(rev) {
      return "4 Model B"
    } else if modelZero.contains(rev) || modelZeroW.contains(rev) {
      return "Zero"
    } else if modelZero2W.contains(rev) {
      return "Zero 2"
    } else {
      return "Unknown"
    }
  }
}
