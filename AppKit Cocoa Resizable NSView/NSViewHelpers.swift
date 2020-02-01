//
//  NSViewHelpers.swift
//  IncomingCallPopup
//
//  Created by Bibin Jacob Pulickal on 10/05/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(Cocoa)
import Cocoa

// MARK: - Properties
public extension NSView {

    @IBInspectable
    var backgroundColor: NSColor? {
        get {
            guard let color = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }

    var origin: CGPoint {
        get {
            frame.origin
        }
        set {
            frame.origin.x = newValue.x
            frame.origin.y = newValue.y
        }
    }

    var size: CGSize {
        get {
            frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    var width: CGFloat {
        get {
            frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    var height: CGFloat {
        get {
            frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    @IBInspectable
    var borderColor: NSColor? {
        get {
            guard let color = layer?.borderColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            layer?.borderWidth ?? 0
        }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer?.cornerRadius ?? 0
        }
        set {
            wantsLayer = true
            layer?.masksToBounds = true
            layer?.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    @IBInspectable
    var shadowColor: NSColor? {
        get {
            guard let color = layer?.shadowColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            layer?.shadowOffset ?? CGSize.zero
        }
        set {
            wantsLayer = true
            layer?.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            layer?.shadowOpacity ?? 0
        }
        set {
            wantsLayer = true
            layer?.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer?.shadowRadius ?? 0
        }
        set {
            wantsLayer = true
            layer?.shadowRadius = newValue
        }
    }

    func addTrackingRect(_ rect: NSRect) {
        addTrackingArea(NSTrackingArea(
            rect: rect,
            options: [
                .mouseMoved,
                .mouseEnteredAndExited,
                .activeAlways],
            owner: self))
    }
}

#endif
