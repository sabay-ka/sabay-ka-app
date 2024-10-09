// Copyright (C) 2019-2024, Magic Lane B.V.
// All rights reserved.
//
// This software is confidential and proprietary information of Magic Lane
// ("Confidential Information"). You shall not disclose such Confidential
// Information and shall use it only in accordance with the terms of the
// license agreement you entered into with Magic Lane.

import UIKit
import Foundation
import Flutter
import GEMKit

public class GemMapController: NSObject, FlutterPlatformView {
    
    var viewId: Int64 = 0
    
    var methodChannel: FlutterMethodChannel?
    
    var sdkChannel: FlutterChannelObject?
    
    var mapViewController: MapViewController?
    
    // var liveDataSourceController: LiveDataSourceController?
    
    public init(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, registrar: FlutterPluginRegistrar?) {
        
        super.init()
        
        self.mapViewController = MapViewController.init()
        self.mapViewController!.view.frame = frame
        self.mapViewController!.hideCompass()
        self.mapViewController!.startRender()
        
        self.registerCallsFromFlutter(viewId: viewId, registrar: registrar)
    }
    
    deinit {
        
        self.clearMapView()
        
        if let mapViewController = self.mapViewController {
            
            mapViewController.destroy()
        }
        
        self.mapViewController = nil
    }
    
    // MARK: - FlutterPlatformView
    
    public func view() -> UIView {
        
        guard let mapViewController = self.mapViewController else { return UIView.init() }
        
        return mapViewController.view
    }
    
    // MARK: - Channel
    
    func registerCallsFromFlutter(viewId: Int64, registrar: FlutterPluginRegistrar?) {
        
        guard self.methodChannel == nil else { return }
        
        guard let registrar = registrar else { return }
        
        self.viewId = viewId
        
        let channelName = String("plugins.flutter.dev/gem_maps_\(viewId)")
        
        self.methodChannel = FlutterMethodChannel.init(name: channelName, binaryMessenger: registrar.messenger())
        
        self.methodChannel!.setMethodCallHandler({ [weak self] (call, result) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.methodCallHandler(call: call, result: result)
        })
        
        self.sdkChannel = FlutterChannelObject.init()
        
        NSLog("GemMapController: channelName:%@, viewId:%d", channelName, viewId)
    }
    
    func methodCallHandler(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        guard let methodChannel = self.methodChannel else { return }
        
        guard let sdkChannel = self.sdkChannel else { return }
        
        if call.method == "waitForViewId" { // GemKitPlatform.init calls: channel.invokeMethod<void>('waitForViewId');
            
            self.registerMapView(result: result)
            
        } else {
            
            if let string = call.arguments as? String, let data = string.data(using: .utf8) {
                
                NSLog("GemMapController: methodCallHandler, call.arguments:%@", string)
                
                sdkChannel.parseMethod(call.method, args: data) { [weak self] eventName, eventData, finalEvent in
                    
                    guard let _ = self else { return }
                    
                    let arguments = String(data: eventData, encoding: .utf8)
                    
                    methodChannel.invokeMethod(eventName, arguments: arguments)
                    
                } completionHandler: { [weak self] code, completionData, waitFutureEvents in
                    
                    guard let _ = self else { return }
                    
                    let arguments = String(data: completionData, encoding: .utf8)
                    
                    if code == .kNoError {
                        
                        result(arguments)
                        
                    } else {
                        
                        let error = FlutterError.init(code: String(format: "%d", code.rawValue), message: arguments, details: nil)
                        
                        result(error)
                    }
                }
            }
        }
    }
    
    // MARK: - SDK Channel
    
    func registerMapView(result: @escaping FlutterResult) {
        
        guard let methodChannel = self.methodChannel else { return }

        guard let sdkChannel = self.sdkChannel else { return }

        guard let mapViewController = self.mapViewController else { return }

        sdkChannel.registerMapView(mapViewController, args: Data.init()) { [weak self] eventName, eventData, finalEvent in
            
            guard let _ = self else { return }

            let arguments = String(data: eventData, encoding: .utf8)

            methodChannel.invokeMethod(eventName, arguments: arguments)

        } completionHandler: { [weak self] code, data, waitFutureEvents in

            guard let _ = self else { return }

            let arguments = String(data: data, encoding: .utf8)

            if code == .kNoError {

                result(arguments)

            } else {

                let error = FlutterError.init(code: String(format: "%d", code.rawValue), message: arguments, details: nil)

                result(error)
            }
        }
    }
    
    func clearMapView() {
        
        guard let sdkChannel = self.sdkChannel else { return }
        
        if let mapViewController = self.mapViewController {
            
            sdkChannel.clearMapView(mapViewController) { code in }
        }
    }
    
    // MARK: - Utils
    
    func convertToDictionary(data: Data) -> [String : Any]? {
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject]
            
            return json
            
        } catch {
            
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func convertToData(json: Any?) -> Data? {
        
        if let object = json {
            
            do {
                
                let data = try JSONSerialization.data(withJSONObject: object, options: [])
                
                return data
                
            } catch {
                
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}
