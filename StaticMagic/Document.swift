//
//  Document.swift
//  StaticMagic
//
//  Created by Mickaël Floc'hlay on 01/10/2020.
//

import Cocoa

class Document: NSDocument {
    var contentString: String?
    var contentViewController: ViewController?
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

//    override class var autosavesInPlace: Bool {
//        return true
//    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)

        // Ugly code
        let splitViewController = windowController.contentViewController as! NSSplitViewController
        contentViewController = splitViewController.splitViewItems[1].viewController as? ViewController
        contentViewController?.editor.string = contentString ?? ""

        windowController.window?.setContentSize(NSSize(width: 800, height: 600))
        windowController.window?.setFrameAutosaveName("windowFrame")
    }

    override func data(ofType typeName: String) throws -> Data {
        guard let data = contentViewController?.editor.string.data(using: .utf8) else {
            throw MarkdownError()
        }
        contentViewController?.editor.breakUndoCoalescing()
        return data
    }

    override func read(from data: Data, ofType typeName: String) throws {
        guard let str = String(data: data, encoding: .utf8) else {
            throw MarkdownError()
        }
        contentString = str
    }

    override class var readableTypes: [String] {
        return ["public.text"]
    }
    
    override class func isNativeType(_ type: String) -> Bool {
        return true
    }
}

struct MarkdownError: Error {}
