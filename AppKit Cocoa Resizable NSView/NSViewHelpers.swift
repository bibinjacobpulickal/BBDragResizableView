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
            return layer?.borderWidth ?? 0
        }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer?.cornerRadius ?? 0
        }
        set {
            wantsLayer = true
            layer?.masksToBounds = true
            layer?.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
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
            return layer?.shadowOffset ?? CGSize.zero
        }
        set {
            wantsLayer = true
            layer?.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer?.shadowOpacity ?? 0
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

    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
}

// MARK: - Methods
extension NSView {

    func addSubviews(_ subviews: [NSView]) {
        subviews.forEach { addSubview($0) }
    }

    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func setBackgroundColor(_ color: NSColor) {
        wantsLayer              = true
        layer?.backgroundColor  = color.cgColor
    }

    func showShadow(_ bool: Bool = true, color: NSColor = .black, radius: CGFloat = 1, opacity: Float = 0.5) {
        if bool {
            wantsLayer              = true
            shadow                  = NSShadow()
            layer?.shadowColor      = color.cgColor
            layer?.shadowOffset     = .zero
            layer?.shadowRadius     = radius
            layer?.shadowOpacity    = opacity
        } else {
            shadow                  = nil
            layer?.shadowOpacity    = 0
            layer?.shadowRadius     = 0
            layer?.shadowColor      = NSColor.clear.cgColor
        }
    }

    func roundCorners(radius: CGFloat?, corners: CACornerMask) {
        wantsLayer                  = true
        layer?.cornerRadius         = radius ?? bounds.height/2
        if !corners.isEmpty {
            layer?.maskedCorners    = corners
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
