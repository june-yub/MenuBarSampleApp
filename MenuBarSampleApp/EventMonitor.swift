//
//  EventMonitor.swift
//  MenuBarSampleApp
//
//  Created by Junyeop Jeon on 10/3/21.
//

import Foundation
import Cocoa

public class EventMonitor
{
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void
    
    // You initialize an instance of this class by passing in a mask of events to listen for things like key down, scroll wheel moved, left mouse button click, etc - and an event handler.
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void)
    {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    // When you're ready to start listening, start() calls addGlobalMonitorForEventsMatchingMask(_:handler:), which returns an object for you to hold on to. Any time the event specified in the mask occurs, the system calls your handler.
    public func start()
    {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    // To remove the global event monitro, you call removeMonitor() in stop() and delete the returned object by setting it to nil.
    public func stop()
    {
        if nil != monitor
        {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
