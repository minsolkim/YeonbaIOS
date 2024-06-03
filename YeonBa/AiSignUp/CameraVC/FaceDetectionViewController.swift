//
//  FaceDetectionViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 4/17/24.
//

import UIKit
import AVFoundation
import Vision

import UIKit
import AVFoundation
import Vision

class FaceDetectionViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private var drawings: [CAShapeLayer] = []
    private let captureButton = UIButton(type: .system)
    private let stillImageOutput = AVCaptureStillImageOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCameraInput()
        self.showCameraFeed()
        self.getCameraFrames()
        self.setupStillImageOutput()
        self.captureSession.startRunning()
        self.setupCaptureButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let navigationController = self.navigationController {
            let topInset = navigationController.navigationBar.frame.height
            let totalTopInset = topInset
            let newFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            self.previewLayer.frame = newFrame
        } else {
            self.previewLayer.frame = self.view.frame
        }
        self.layoutCaptureButton()
    }
    
    private func setupCaptureButton() {
        self.captureButton.setTitle("Capture", for: .normal)
        self.captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        self.view.addSubview(self.captureButton)
        self.captureButton.isEnabled = false // 처음에는 비활성화된 상태로 시작
    }
    
    private func layoutCaptureButton() {
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 40
        let buttonX = (self.view.bounds.width - buttonWidth) / 2
        let buttonY = self.view.bounds.height - buttonHeight - 20 // 버튼이 화면 하단에 위치하도록 설정
        self.captureButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
    }
    
    private func setupStillImageOutput() {
        if self.captureSession.canAddOutput(self.stillImageOutput) {
            self.captureSession.addOutput(self.stillImageOutput)
        }
    }
    
    @objc private func captureButtonTapped() {
        guard let videoConnection = self.stillImageOutput.connection(with: .video) else {
            debugPrint("Failed to get video connection")
            return
        }
        
        // 셀카를 찍기 위해 비디오 피드의 현재 프레임을 캡처합니다.
        self.stillImageOutput.captureStillImageAsynchronously(from: videoConnection) { (buffer, error) in
            guard let buffer = buffer, error == nil else {
                debugPrint("Error capturing still image: \(error?.localizedDescription ?? "")")
                return
            }
            
            // 캡처한 이미지 데이터를 UIImage로 변환합니다.
            if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer),
               let capturedImage = UIImage(data: imageData) {
                
                // 캡처한 이미지를 SignDataManager.selfieImage에 저장합니다.
                SignDataManager.shared.selfieImage = capturedImage
                
                // 이미지 저장 후에 필요한 추가 작업 수행 가능
                
                // 예: 캡처된 이미지를 다른 뷰 컨트롤러에 전달하거나 표시하는 등의 작업
                let ASVC = AnalysisSyncViewController()
                self.navigationController?.pushViewController(ASVC, animated: true)
                // UI 업데이트는 메인 스레드에서 수행되어야 합니다.
                DispatchQueue.main.async {
                    
                }
            } else {
                debugPrint("Failed to convert image data to UIImage")
            }
        }
    }
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection) {
        
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        self.detectFace(in: frame)
    }
    
    private func addCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .front).devices.first else {
                fatalError("No back camera device found, please make sure to run SimpleLaneDetection in an iOS device and not a simulator")
        }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }
    
    private func showCameraFeed() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.frame
    }
    
    private func getCameraFrames() {
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        guard let connection = self.videoDataOutput.connection(with: AVMediaType.video),
            connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
    }
    
    private func detectFace(in image: CVPixelBuffer) {
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                if let results = request.results as? [VNFaceObservation] {
                    self.handleFaceDetectionResults(results)
                } else {
                    self.clearDrawings()
                    self.captureButton.isEnabled = false // 얼굴이 인식되지 않으면 촬영 버튼 비활성화
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([faceDetectionRequest])
    }
    
    private func handleFaceDetectionResults(_ observedFaces: [VNFaceObservation]) {
        self.clearDrawings()
        
        if observedFaces.isEmpty {
            self.captureButton.isEnabled = false // 얼굴이 인식되지 않으면 촬영 버튼 비활성화
            return
        }
        
        let facesBoundingBoxes: [CAShapeLayer] = observedFaces.flatMap({ (observedFace: VNFaceObservation) -> [CAShapeLayer] in
            let faceBoundingBoxOnScreen = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observedFace.boundingBox)
            let faceBoundingBoxPath = CGPath(rect: faceBoundingBoxOnScreen, transform: nil)
            let faceBoundingBoxShape = CAShapeLayer()
            faceBoundingBoxShape.path = faceBoundingBoxPath
            faceBoundingBoxShape.fillColor = UIColor.clear.cgColor
            faceBoundingBoxShape.strokeColor = UIColor.green.cgColor
            var newDrawings = [CAShapeLayer]()
            newDrawings.append(faceBoundingBoxShape)
            if let landmarks = observedFace.landmarks {
                newDrawings = newDrawings + self.drawFaceFeatures(landmarks, screenBoundingBox: faceBoundingBoxOnScreen)
            }
            return newDrawings
        })
        facesBoundingBoxes.forEach({ faceBoundingBox in self.view.layer.addSublayer(faceBoundingBox) })
        self.drawings = facesBoundingBoxes
        
        self.captureButton.isEnabled = true // 얼굴이 인식되면 촬영 버튼 활성화
    }
    
    private func clearDrawings() {
        self.drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
    }
    
    private func drawFaceFeatures(_ landmarks: VNFaceLandmarks2D, screenBoundingBox: CGRect) -> [CAShapeLayer] {
        var faceFeaturesDrawings: [CAShapeLayer] = []
        if let leftEye = landmarks.leftEye {
            let eyeDrawing = self.drawEye(leftEye, screenBoundingBox: screenBoundingBox)
            faceFeaturesDrawings.append(eyeDrawing)
        }
        if let rightEye = landmarks.rightEye {
            let eyeDrawing = self.drawEye(rightEye, screenBoundingBox: screenBoundingBox)
            faceFeaturesDrawings.append(eyeDrawing)
        }
        // draw other face features here
        return faceFeaturesDrawings
    }
    
    private func drawEye(_ eye: VNFaceLandmarkRegion2D, screenBoundingBox: CGRect) -> CAShapeLayer {
        let eyePath = CGMutablePath()
        let eyePathPoints = eye.normalizedPoints
            .map({ eyePoint in
                CGPoint(
                    x: eyePoint.y * screenBoundingBox.height + screenBoundingBox.origin.x,
                    y: eyePoint.x * screenBoundingBox.width + screenBoundingBox.origin.y)
            })
        eyePath.addLines(between: eyePathPoints)
        eyePath.closeSubpath()
        let eyeDrawing = CAShapeLayer()
        eyeDrawing.path = eyePath
        eyeDrawing.fillColor = UIColor.clear.cgColor
        eyeDrawing.strokeColor = UIColor.green.cgColor
        
        return eyeDrawing
    }
}
