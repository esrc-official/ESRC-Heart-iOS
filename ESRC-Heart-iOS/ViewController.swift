//
//  ViewController.swift
//  ESRC-Heart-iOS
//
//  Created by Hyunwoo Lee on 25/10/2021.
//  Copyright © 2021 ESRC. All rights reserved.
//

import UIKit
import AVFoundation
import ESRC_Heart_SDK_iOS

class ViewController:  UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    // ESRC variables
    let APP_ID: String = ""  // Applocation ID.
    let ENABLE_DRAW: Bool = true;  // Enablement of visualization.
    var frame: UIImage? = nil
    var face: ESRCFace? = nil
    
    // Camera variables
    @IBOutlet weak var preview: UIImageView!
    var captureSession: AVCaptureSession!
    var videoOutput: AVCaptureVideoDataOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var overlayLayer: CAShapeLayer!
    
    // Timer variables
    var timer: Timer?
    
    // Layout variables
    @IBOutlet weak var facebox_image: UIImageView!
    @IBOutlet weak var info_container: UIView!
    @IBOutlet weak var upper_line_container: UIView!
    @IBOutlet weak var under_line_container: UIView!
    @IBOutlet weak var hr_container: UIView!
    @IBOutlet weak var hrv_sdnn_container: UIView!
    @IBOutlet weak var hrv_rmssd_container: UIView!
    @IBOutlet weak var hrv_lnlf_container: UIView!
    @IBOutlet weak var hrv_lnhf_container: UIView!
    @IBOutlet weak var ans_balance_container: UIView!
    
    @IBOutlet weak var hr_indicator: UIActivityIndicatorView!
    @IBOutlet weak var hr_title_text: UITextField!
    @IBOutlet weak var hr_unit_text: UITextField!
    @IBOutlet weak var hr_val_text: UITextView!
    
    @IBOutlet weak var hrv_sdnn_indicator: UIActivityIndicatorView!
    @IBOutlet weak var hrv_sdnn_title_text: UITextField!
    @IBOutlet weak var hrv_sdnn_unit_text: UITextField!
    @IBOutlet weak var hrv_sdnn_val_text: UITextView!
    
    @IBOutlet weak var hrv_rmssd_indicator: UIActivityIndicatorView!
    @IBOutlet weak var hrv_rmssd_title_text: UITextField!
    @IBOutlet weak var hrv_rmssd_unit_text: UITextField!
    @IBOutlet weak var hrv_rmssd_val_text: UITextView!
    
    @IBOutlet weak var hrv_lnlf_indicator: UIActivityIndicatorView!
    @IBOutlet weak var hrv_lnlf_title_text: UITextField!
    @IBOutlet weak var hrv_lnlf_unit_text: UITextField!
    @IBOutlet weak var hrv_lnlf_val_text: UITextView!
    
    @IBOutlet weak var hrv_lnhf_indicator: UIActivityIndicatorView!
    @IBOutlet weak var hrv_lnhf_title_text: UITextField!
    @IBOutlet weak var hrv_lnhf_unit_text: UITextField!
    @IBOutlet weak var hrv_lnhf_val_text: UITextView!
    
    @IBOutlet weak var ans_balance_indicator: UIActivityIndicatorView!
    @IBOutlet weak var ans_balance_title_text: UITextField!
    @IBOutlet weak var ans_balance_unit_text: UITextField!
    @IBOutlet weak var ans_balance_val_text: UITextView!
    
    var hr_circularView = CircularProgressBarView(frame: .zero)
    var hrv_sdnn_circularView = CircularProgressBarView(frame: .zero)
    var hrv_rmssd_circularView = CircularProgressBarView(frame: .zero)
    var hrv_lnlf_circularView = CircularProgressBarView(frame: .zero)
    var hrv_lnhf_circularView = CircularProgressBarView(frame: .zero)
    var ans_balance_circularView = CircularProgressBarView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Always screen on
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Initialize face box
        facebox_image.layer.borderWidth = 4
        facebox_image.layer.borderColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0).cgColor
        
        // Initialize container
        info_container.backgroundColor = UIColor(white: 1, alpha: 0.0)
        upper_line_container.backgroundColor = UIColor(white: 1, alpha: 0.0)
        under_line_container.backgroundColor = UIColor(white: 1, alpha: 0.0)
        hr_container.layer.cornerRadius = 10
        hrv_sdnn_container.layer.cornerRadius = 10
        hrv_rmssd_container.layer.cornerRadius = 10
        hrv_lnlf_container.layer.cornerRadius = 10
        hrv_lnhf_container.layer.cornerRadius = 10
        ans_balance_container.layer.cornerRadius = 10
        
        // Start indicator animation
        hr_indicator.startAnimating()
        hrv_sdnn_indicator.startAnimating()
        hrv_rmssd_indicator.startAnimating()
        hrv_lnlf_indicator.startAnimating()
        hrv_lnhf_indicator.startAnimating()
        ans_balance_indicator.startAnimating()
        
        // Initialize progress bar constraints
        hr_circularView.center = hr_container.center
        hr_container.addSubview(hr_circularView)
        hr_circularView.translatesAutoresizingMaskIntoConstraints = false
        hr_circularView.centerXAnchor.constraint(equalTo:hr_container.centerXAnchor).isActive = true // ---- 1
        hr_circularView.centerYAnchor.constraint(equalTo:hr_container.centerYAnchor).isActive = true // ---- 2
        hrv_sdnn_circularView.center = hrv_sdnn_container.center
        hrv_sdnn_container.addSubview(hrv_sdnn_circularView)
        hrv_sdnn_circularView.translatesAutoresizingMaskIntoConstraints = false
        hrv_sdnn_circularView.centerXAnchor.constraint(equalTo:hrv_sdnn_container.centerXAnchor).isActive = true // ---- 1
        hrv_sdnn_circularView.centerYAnchor.constraint(equalTo:hrv_sdnn_container.centerYAnchor).isActive = true // ---- 2
        hrv_rmssd_circularView.center = hrv_rmssd_container.center
        hrv_rmssd_container.addSubview(hrv_rmssd_circularView)
        hrv_rmssd_circularView.translatesAutoresizingMaskIntoConstraints = false
        hrv_rmssd_circularView.centerXAnchor.constraint(equalTo:hrv_rmssd_container.centerXAnchor).isActive = true // ---- 1
        hrv_rmssd_circularView.centerYAnchor.constraint(equalTo:hrv_rmssd_container.centerYAnchor).isActive = true // ---- 2
        hrv_lnlf_circularView.center = hrv_lnlf_container.center
        hrv_lnlf_container.addSubview(hrv_lnlf_circularView)
        hrv_lnlf_circularView.translatesAutoresizingMaskIntoConstraints = false
        hrv_lnlf_circularView.centerXAnchor.constraint(equalTo:hrv_lnlf_container.centerXAnchor).isActive = true // ---- 1
        hrv_lnlf_circularView.centerYAnchor.constraint(equalTo:hrv_lnlf_container.centerYAnchor).isActive = true // ---- 2
        hrv_lnhf_circularView.center = hrv_lnhf_container.center
        hrv_lnhf_container.addSubview(hrv_lnhf_circularView)
        hrv_lnhf_circularView.translatesAutoresizingMaskIntoConstraints = false
        hrv_lnhf_circularView.centerXAnchor.constraint(equalTo:hrv_lnhf_container.centerXAnchor).isActive = true // ---- 1
        hrv_lnhf_circularView.centerYAnchor.constraint(equalTo:hrv_lnhf_container.centerYAnchor).isActive = true // ---- 2
        ans_balance_circularView.center = ans_balance_container.center
        ans_balance_container.addSubview(ans_balance_circularView)
        ans_balance_circularView.translatesAutoresizingMaskIntoConstraints = false
        ans_balance_circularView.centerXAnchor.constraint(equalTo:ans_balance_container.centerXAnchor).isActive = true // ---- 1
        ans_balance_circularView.centerYAnchor.constraint(equalTo:ans_balance_container.centerYAnchor).isActive = true // ---- 2
        
        // Show circular view
        hr_circularView.isHidden = true
        hrv_sdnn_circularView.isHidden = true
        hrv_rmssd_circularView.isHidden = true
        hrv_lnlf_circularView.isHidden = true
        hrv_lnhf_circularView.isHidden = true
        ans_balance_circularView.isHidden = true
    }
    
    func drawImage(size: CGSize, image: UIImage, width: Double, height: Double) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.draw(at: CGPoint.zero)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.addRect(CGRect(x:0, y:0, width: width, height: height))
        context.strokePath()

        guard let resultImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup session
        captureSession = AVCaptureSession()
        
        // Select input device
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            else {
                fatalError("Unable to access front caemra.")
        }

        do {
            // Prepare the input
            let captureInput = try AVCaptureDeviceInput(device: device)
            
            // Configure the output
            videoOutput = AVCaptureVideoDataOutput()
            videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) :
                                            NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
            videoOutput.alwaysDiscardsLateVideoFrames = true
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera.frame.processing.queue"))
       
            // Attach the input and output
            if captureSession.canAddInput(captureInput) && captureSession.canAddOutput(videoOutput) {
                captureSession.addInput(captureInput)
                captureSession.addOutput(videoOutput)
                
                // Configure the output connection
                if let connection = self.videoOutput.connection(with: AVMediaType.video),
                   connection.isVideoOrientationSupported {
                    connection.videoOrientation = .portrait
                    connection.isVideoMirrored = true
                }

                // Setup the preview
                setupPreview()
            }
        }
        catch _ {
            fatalError("Error Unable to initialize front camera.")
        }
        
        // Initialize ESRC
        if(!ESRC.initWithApplicationId(appId: APP_ID, licenseHandler: self)) {
            print("ESRC init is failed.")
        } else {
            // Start ESRC
            if(!ESRC.start(handler: self)) {
                print("ESRC start is failed.")
            }
            
            // Start timer (10 fps)
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                // Feed ESRC
                if(self.frame != nil) {
                    ESRC.feed(frame: self.frame!)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop timer
        self.timer?.invalidate()
        
        // Release ESRC
        if(!ESRC.stop()) {
            print("ESRC stop is failed.")
        }

        // Stop the session on the background thread
        self.captureSession.stopRunning()
    }
    
    func setupPreview() {
        // Configure the preview
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspect
        previewLayer.connection?.videoOrientation = .portrait
        preview.layer.addSublayer(previewLayer)
        
        // Configure the overlay
        overlayLayer = CAShapeLayer()
        preview.layer.addSublayer(overlayLayer)

        // Start the session on the background thread
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()

            // Size the preview layer to fit the preview
            DispatchQueue.main.async {
                self.previewLayer.frame = self.preview.bounds
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let videoBuffer = CMSampleBufferGetImageBuffer(sampleBuffer), let _ = CMSampleBufferGetFormatDescription(sampleBuffer) else {return}
        let captureImage = CIImage(cvImageBuffer: videoBuffer)
        let context: CIContext = CIContext.init(options: nil)
        let cgImage = context.createCGImage(captureImage, from: captureImage.extent)!
        let image = UIImage(cgImage: cgImage)
        
        // Set frame
        self.frame = image
        
        // Draw
        if (ENABLE_DRAW) {
            DispatchQueue.main.async {
                self.draw(image: image)
            }
        }

    }
    
    func draw(image: UIImage) {
        if (self.face != nil) {
            let wRatio: CGFloat = self.preview.frame.size.width / image.size.width
            let hRatio : CGFloat = self.preview.frame.size.height / image.size.height
            self.overlayLayer.path = UIBezierPath(roundedRect: CGRect(x: (CGFloat)(self.face!.getX()) * wRatio, y: (CGFloat)(self.face!.getY()) * hRatio, width: (CGFloat)(self.face!.getW()) * wRatio, height: (CGFloat)(self.face!.getH()) * hRatio), cornerRadius: 0).cgPath
            self.overlayLayer.strokeColor = UIColor.red.cgColor
            self.overlayLayer.lineWidth = 3
            self.overlayLayer.fillColor = UIColor.clear.cgColor
        } else {
            self.overlayLayer.path = nil
        }
    }
}

extension ViewController: ESRCLicenseHandler, ESRCHandler {
    
    func onValidatedLicense() {
        print("onValidatedLicense.")
    }
    
    func onInvalidatedLicense() {
        print("onInvalidatedLicense.")
    }
    
    func onDetectedFace(face: ESRCFace) {
        print("onDetectedFace: " + face.toString())
        self.face = face
        
        facebox_image.layer.borderWidth = 8
        facebox_image.layer.borderColor = UIColor(red: 0.92, green: 0.0, blue: 0.55, alpha: 1.0).cgColor
    }
    
    func onNotDetectedFace() {
        print("onNotDetectedFace")
        self.face = nil
        
        facebox_image.layer.borderWidth = 4
        facebox_image.layer.borderColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0).cgColor
    }
    
    func didChangedProgressRatioOnRemoteHR(progressRatio: Double) {
        print("didChangedProgressRatioOnRemoteHR: " + (String)(progressRatio))
        
        if (hr_indicator.isAnimating == true) {
            hr_indicator.stopAnimating()
        }

        // display progress bar
        if(progressRatio < 100){
            hr_circularView.isHidden = false
            hr_circularView.progressAnimation(ratio: progressRatio, oneStep: 0.01)
        }
    }
    
    func onEstimatedRemoteHR(remoteHR: ESRCRemoteHR) {
        print("onEstimatedRemoteHR: " + remoteHR.toString())
        
        // Hide circular view and show text
        hr_circularView.isHidden = true
        hr_val_text.isHidden = false
        hr_unit_text.isHidden = false
        
        // Set HR value
        hr_val_text.text = String(format: "%.0f", remoteHR.getHR())
    }
    
    func didChangedProgressRatioOnHRV(progressRatio: Double) {
        print("didChangedProgressRatioOnHRV: " + (String)(progressRatio))
        
        // Stop indicator animation
        if (hrv_sdnn_indicator.isAnimating == true) {
            hrv_sdnn_indicator.stopAnimating()
            hrv_rmssd_indicator.stopAnimating()
            hrv_lnlf_indicator.stopAnimating()
            hrv_lnhf_indicator.stopAnimating()
            ans_balance_indicator.stopAnimating()
        }

        // Display progress bar
        if(progressRatio < 100){
            hrv_sdnn_circularView.isHidden = false
            hrv_rmssd_circularView.isHidden = false
            hrv_lnlf_circularView.isHidden = false
            hrv_lnhf_circularView.isHidden = false
            ans_balance_circularView.isHidden = false
            hrv_sdnn_circularView.progressAnimation(ratio: progressRatio, oneStep: 0.01666)
            hrv_rmssd_circularView.progressAnimation(ratio: progressRatio, oneStep: 0.01666)
            hrv_lnlf_circularView.progressAnimation(ratio: progressRatio, oneStep: 0.01666)
            hrv_lnhf_circularView.progressAnimation(ratio: progressRatio, oneStep: 0.01666)
            ans_balance_circularView.progressAnimation(ratio: progressRatio, oneStep: 0.01666)
        }
    }
    
    func onAnalyzedHRV(hrv: ESRCHRV) {
        print("onAnalyzedHRV: " + hrv.toString())
    
        // Hide circular view and show text
        hrv_sdnn_circularView.isHidden = true
        hrv_sdnn_val_text.isHidden = false
        hrv_sdnn_unit_text.isHidden = false
        hrv_rmssd_circularView.isHidden = true
        hrv_rmssd_val_text.isHidden = false
        hrv_rmssd_unit_text.isHidden = false
        hrv_lnlf_circularView.isHidden = true
        hrv_lnlf_val_text.isHidden = false
        hrv_lnlf_unit_text.isHidden = false
        hrv_lnhf_circularView.isHidden = true
        hrv_lnhf_val_text.isHidden = false
        hrv_lnhf_unit_text.isHidden = false
        ans_balance_circularView.isHidden = true
        ans_balance_val_text.isHidden = false
        ans_balance_unit_text.isHidden = false
        
        // Set HRV values
        hrv_sdnn_val_text.text = String(format: "%.2f", hrv.getSdnn())
        hrv_rmssd_val_text.text = String(format: "%.2f", hrv.getRmssd())
        hrv_lnlf_val_text.text = String(format: "%.2f", hrv.getLnLf())
        hrv_lnhf_val_text.text = String(format: "%.2f", hrv.getLnHf())
        ans_balance_val_text.text = String(format: "%.2f", hrv.getLfHf())
    }
}
