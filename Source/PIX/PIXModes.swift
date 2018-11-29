//
//  PIXModes.swift
//  Pixels
//
//  Created by Hexagons on 2018-08-23.
//  Copyright © 2018 Hexagons. All rights reserved.
//

import MetalPerformanceShaders

extension PIX {
    
    public enum FillMode {
        
        case fill
        case aspectFit
        case aspectFill
        
        case center
        public enum Vertical: String {
            case bottom
            case center
            case top
            var index: Int {
                switch self {
                case .bottom: return 0
                case .center: return 1
                case .top: return 2
                }
            }
        }
        public enum Horizontal: String {
            case left
            case center
            case right
            var index: Int {
                switch self {
                case .left: return 0
                case .center: return 1
                case .right: return 2
                }
            }
        }
        case place(Vertical, Horizontal)
        
        var index: Int {
            switch self {
            case .fill: return 0
            case .aspectFit: return 1
            case .aspectFill: return 2
            case .center: return 3
            case .place(_, _): return 4
            }
        }
        
        var name: String {
            switch self {
            case .fill: return "fill"
            case .aspectFit: return "aspectFit"
            case .aspectFill: return "aspectFill"
            case .center: return "center"
            case .place(let v, let h): return "place:\(v):\(h)"
            }
        }
        
        init(name: String) {
            switch name {
            case "fill": self = .fill
            case "aspectFit": self = .aspectFit
            case "aspectFill": self = .aspectFill
            case "center": self = .center
            default:
                if name.starts(with: "place") {
                    let subNames = name.split(separator: ":")
                    if subNames.count == 3 {
                        let vName = String(subNames[1])
                        let hName = String(subNames[2])
                        if let v = Vertical.init(rawValue: vName), let h = Horizontal.init(rawValue: hName) {
                            self = .place(v, h)
                            return
                        }
                    }
                }
                Pixels.main.log(.error, nil, "Bad FillMode: \"\(name)\"")
                self = .fill
            }
        }
        
    }
    
    public enum BlendingMode: String, Codable {
        case over
        case under
        case add
        case multiply
        case difference
        case subtractWithAlpha
        case subtract
        case maximum
        case minimum
        case gamma
        case power
        case divide
        var index: Int {
            switch self {
            case .over: return 0
            case .under: return 1
            case .add: return 2
            case .multiply: return 3
            case .difference: return 4
            case .subtractWithAlpha: return 5
            case .subtract: return 6
            case .maximum: return 7
            case .minimum: return 8
            case .gamma: return 9
            case .power: return 10
            case .divide: return 11
            }
        }
    }
    
    public enum InterpolateMode: String, Codable {
        case nearest
        case linear
        var mtl: MTLSamplerMinMagFilter {
            switch self {
            case .nearest: return .nearest
            case .linear: return .linear
            }
        }
    }
    
    public enum ExtendMode: String, Codable {
        case hold
        case zero
        case `repeat`
        case mirror
        var mtl: MTLSamplerAddressMode {
            switch self {
            case .hold: return .clampToEdge
            case .zero: return .clampToZero
            case .repeat: return .repeat
            case .mirror: return .mirrorRepeat
            }
        }
        var mps: MPSImageEdgeMode {
            switch self {
            case .zero: return .zero
            default: return .clamp
            }
        }
        var index: Int {
            switch self {
            case .hold: return 0
            case .zero: return 1
            case .repeat: return 2
            case .mirror: return 3
            }
        }
    }
    
    public enum SampleQualityMode: Int, Codable {
        case low = 4
        case mid = 8
        case high = 16
        case extreme = 32
        case insane = 64
        case epic = 128
    }
    
}
