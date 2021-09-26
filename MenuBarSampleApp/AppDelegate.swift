//
//  AppDelegate.swift
//  MenuBarSampleApp
//
//  Created by Junyeop Jeon on 9/26/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    // This creates a Status Item - aka application icon - in the menu bar with a fixed length that the user will see and use..
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    @objc func printQuote(_sender: Any?)
    {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) - \(quoteAuthor)")
    }
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let button = statusItem.button
        {
            // for its icon
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
            
            // for the action when it is clicked..
            button.action = #selector(printQuote(_sender:))
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

