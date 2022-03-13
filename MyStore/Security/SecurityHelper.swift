//
//  SecurityHelper.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class SecurityHelper {
    
    // check if Jail Broken
    private static var isJailBroken: Bool {
        if UIDevice.current.isSimulator {
            return false
        }
        
        if SecurityHelper.hasCydiaInstalled() || SecurityHelper.isContainsSuspiciousApps() || SecurityHelper.isSuspiciousSystemPathsExists() {
            return true
        }
        
        return SecurityHelper.canEditSystemFiles()
    }
    
    // check if cydia is installed (using URI Scheme)
    private class func hasCydiaInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    // Check if suspicious apps (Cydia, FakeCarrier, Icy etc.) is installed
    private class func isContainsSuspiciousApps() -> Bool {
        for path in suspiciousAppsPathToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    // Check if system contains suspicious files
    private class func isSuspiciousSystemPathsExists() -> Bool {
        for path in suspiciousSystemPathsToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    // Check if app can edit system files
    private class func canEditSystemFiles() -> Bool {
        let jailBreakText = "Developer Insider"
        do {
            try jailBreakText.write(toFile: jailBreakText, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
    
    // suspicious apps path to check
    private static var suspiciousAppsPathToCheck: [String] {
        return ["/Applications/Cydia.app",
                "/Applications/blackra1n.app",
                "/Applications/FakeCarrier.app",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/WinterBoard.app"
        ]
    }
    
    // suspicious system paths to check
    private static var suspiciousSystemPathsToCheck: [String] {
        return ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/private/var/lib/apt",
                "/private/var/lib/apt/",
                "/private/var/lib/cydia",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/private/var/stash",
                "/private/var/tmp/cydia.log",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/usr/bin/sshd",
                "/usr/libexec/sftp-server",
                "/usr/sbin/sshd",
                "/etc/apt",
                "/bin/bash",
                "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
    }
    
    class func applicationDidBecomeActive() {
        
        // Try to open cydia app always. it will open cydia app on jailbroken device forever.
        guard let url = URL(string: "cydia://") else { return }
        UIApplication.shared.open(url, options: [:]) { []opened in
            if opened { exit(0) }
        }
    }
    
    class func checkForBreaking(completion: GenericClosure<Bool>? = nil) {
        if isJailBroken {
            completion?(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Alert(title: &&"Common.Error",
                             message: &&"Error.JailBreak,Message",
                             preferredStyle: .alert)
                    .addAction(title: &&"Common.Ok", style: .cancel, handler: {
                        exit(0)
                    })
                    .build()
                    .show()
            }
        } else {
            completion?(false)
        }
    }
}
