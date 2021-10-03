//
//  AppDelegate.swift
//  MenuBarSampleApp
//
//  Created by Junyeop Jeon on 9/26/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

//MARK:- Status Item
    // This creates a Status Item - aka application icon - in the menu bar with a fixed length that the user will see and use..
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

//    //Test Code
//    @objc func printQuote(_sender: Any?)
//    {
//        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
//        let quoteAuthor = "Mark Twain"
//
//        print("\(quoteText) - \(quoteAuthor)")
//    }
    
    func constructMenu()
    {
        let menu = NSMenu()
        
//        // Test Code
//        menu.addItem(NSMenuItem(title: "Print Quote",
//                                action: #selector(AppDelegate.printQuote(_sender:)),
//                                keyEquivalent: "P"))
//        menu.addItem(NSMenuItem.separator())
//        menu.addItem(NSMenuItem(title: "Quit Quote",
//                                action: #selector(NSApplication.terminate(_:)),
//                                keyEquivalent: "q"))
        
        statusItem.menu = menu
        assert( nil != statusItem.menu )
    }
    
//MARK:- Popover
    
    let popover = NSPopover()
    
    @objc func togglePopOver(_ sender: Any?)
    {
        if popover.isShown
        {
            closePopover(sender: sender)
        }
        else
        {
            showPopover(sender: sender)
        }
    }
    
    // Displays the popover to the user. You just need to supply a source rect and macOS will position the popover and arrow so it looks like it's coming out of the menu bar icon.
    func showPopover(sender: Any?)
    {
        if let button = statusItem.button
        {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            
            // for Event Monitor
            eventMonitor?.start()
        }
        else
        {
            assertionFailure("Failed to show popover")
        }
    }
    
    
    func closePopover(sender: Any?)
    {
        popover.performClose(sender)
        
        //for Event Monitor
        eventMonitor?.stop()
    }
    
    
// MARK:- EVENT MONITOR
    
    var eventMonitor: EventMonitor?
    
    
//MARK:- Application
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let button = statusItem.button
        {
            // for its icon
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
            assert( nil != button.image )
            
            // for the action when it is clicked..
            
            button.action = #selector(togglePopOver(_:))
            assert( nil != button.action )
        }
        else
        {
            assertionFailure("Failed to get statusItem.button")
        }
        
        popover.contentViewController = QuotesViewController.freshController()
        
        //Test Code
        //constructMenu()
        
        
        // This notifies your app of any left or right mouse down event and closes the popover when the system event occurs. Note that your handler will not be called for events that are sent to your own application. That's why the popover doesn't close when you click around inside of it.
        // You use a weak reference to self to avoid a potential retain cycle between AppDeletgate and EventMonitor. It's not essential in this particular situation because there's only one setup cycle but is something to watch out for in your own code when you use block handlers between object.
        eventMonitor = EventMonitor( mask: [.leftMouseDown, .rightMouseDown] )
        {   [weak self] event in
            
            if let strongSelf = self, strongSelf.popover.isShown
            {
                strongSelf.closePopover(sender: event)
            }
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

