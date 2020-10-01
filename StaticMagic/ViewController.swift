//
//  ViewController.swift
//  StaticMagic
//
//  Created by Mickaël Floc'hlay on 01/10/2020.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var editor: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editor.allowsUndo = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

