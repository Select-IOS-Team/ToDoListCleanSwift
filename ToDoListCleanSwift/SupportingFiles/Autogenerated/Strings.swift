// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum LoginScene {
    /// Enter login
    internal static let loginTextFieldPlaceholder = L10n.tr("Localizable", "LoginScene.loginTextFieldPlaceholder")
    /// Enter password
    internal static let passwordTextFieldPlaceholder = L10n.tr("Localizable", "LoginScene.passwordTextFieldPlaceholder")
    /// Sign in
    internal static let signInButtonTitle = L10n.tr("Localizable", "LoginScene.signInButtonTitle")

    internal enum AlertActions {
      /// Error
      internal static let error = L10n.tr("Localizable", "LoginScene.AlertActions.Error")
      /// OK
      internal static let ok = L10n.tr("Localizable", "LoginScene.AlertActions.OK")
    }
  }

  internal enum TasksScene {
    /// checkmark.circle.fill
    internal static let completedCheckboxImageName = L10n.tr("Localizable", "TasksScene.completedCheckboxImageName")
    /// Completed tasks
    internal static let completedTasks = L10n.tr("Localizable", "TasksScene.completedTasks")
    /// dd.MM.yyyy HH:mm
    internal static let dateFormat = L10n.tr("Localizable", "TasksScene.dateFormat")
    /// high
    internal static let priorityHigh = L10n.tr("Localizable", "TasksScene.priorityHigh")
    /// Priority: 
    internal static let priorityLabelText = L10n.tr("Localizable", "TasksScene.priorityLabelText")
    /// low
    internal static let priorityLow = L10n.tr("Localizable", "TasksScene.priorityLow")
    /// medium
    internal static let priorityMedium = L10n.tr("Localizable", "TasksScene.priorityMedium")
    /// To-do List
    internal static let title = L10n.tr("Localizable", "TasksScene.title")
    /// circle
    internal static let uncompletedCheckboxImageName = L10n.tr("Localizable", "TasksScene.uncompletedCheckboxImageName")
    /// Uncompleted tasks
    internal static let uncompletedTasks = L10n.tr("Localizable", "TasksScene.uncompletedTasks")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all