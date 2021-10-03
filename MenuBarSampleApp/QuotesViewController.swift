//
//  QuotesViewController.swift
//  MenuBarSampleApp
//
//  Created by Junyeop Jeon on 9/26/21.
//

import Cocoa

class QuotesViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        currentQuoteIndex = 0
    }
    
    func updateQuote()
    {
        textLabel.stringValue = String(describing: quotes[currentQuoteIndex])
    }
    
    @IBOutlet var textLabel: NSTextField!
    
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0
    {
        didSet
        {
            updateQuote()
        }
    }
    
}

extension QuotesViewController
{
    //Mark: Storyboard instantiation
    static func freshController() -> QuotesViewController
    {
        // Get a reference to Main.storyboard
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"),
                                      bundle: nil)
        
        // Create a Scene identifier that matches the one you set in Main.storyboard
        let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
        
        // Instantiate QuotesViewController and return it
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? QuotesViewController
        else
        {
            fatalError("Check Main.storyboard")
        }
        return viewcontroller
    }
    
}

extension QuotesViewController
{
    @IBAction func previous(_ sender: NSButton)
    {
        currentQuoteIndex = ( currentQuoteIndex - 1 + quotes.count ) % quotes.count
    }
    
    @IBAction func next(_ sender: NSButton)
    {
        currentQuoteIndex = ( currentQuoteIndex + 1 ) % quotes.count
    }
    
    @IBAction func quit(_ sender: NSButton)
    {
        NSApplication.shared.terminate(sender)
    }
}
