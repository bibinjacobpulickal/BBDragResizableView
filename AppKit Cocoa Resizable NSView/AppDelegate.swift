//
//  AppDelegate.swift
//  CocoaTest
//
//  Created by Bibin Jacob Pulickal on 21/05/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(contentViewController: ContentViewController())
        window?.makeKeyAndOrderFront(nil)
        setCustomToolBar()
    }

    func setCustomToolBar() {
        let customToolbar = NSToolbar()
        customToolbar.showsBaselineSeparator = false
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.styleMask.insert(.fullSizeContentView)
        window?.toolbar = customToolbar
    }
}

class ContentViewController: NSSplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSplitViewItem(NSSplitViewItem(sidebarWithViewController: SideBarViewController()))
        addSplitViewItem(NSSplitViewItem(viewController: ViewController()))
    }
}

class SideBarViewController: NSViewController {
    override func loadView() {
        view        = NSView()
        view.anchor(lhs: .width, rhs: 200)
    }
}

