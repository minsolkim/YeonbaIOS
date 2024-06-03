//
//  VoiceRecordingViewController.swift
//  YeonBa
//
//  Created by jin on 3/6/24.
//

import UIKit
import Foundation
import AVFoundation
import Accelerate
import CoreML


class VoiceRecordingViewController: UIViewController, AVAudioRecorderDelegate {
    
    //MARK: - UI Components
    var waveformView = WaveformView().then{
        $0.backgroundColor = .clear
    }
    let titleLabel = UILabel().then{
        $0.text = "AI 음역대 측정"
        $0.font = UIFont.pretendardMedium(size: 18)
    }
    let backButton = UIButton(type: .system).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .light)
        let image = UIImage(named: "BackButton")
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor.black
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    let recordingIndicatorView = UIView().then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 5
        $0.isHidden = true
    }
    
    let recordingLabel = UILabel().then {
        $0.text = "녹음 중.."
        $0.isHidden = true
        $0.font = UIFont.pretendardMedium(size: 18)
    }
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 79.5
        $0.layer.borderWidth = 4
        $0.layer.borderColor = UIColor.white.cgColor
        $0.clipsToBounds = true
    }
    
    let profileImageBGView = UIImageView().then {
        $0.layer.cornerRadius = 87.5
        $0.clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 175, height: 175)
        gradientLayer.colors = [UIColor(hex: "FF8F96").cgColor, UIColor(hex: "FF2149").cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        // 이미지뷰의 배경으로 그라데이션 적용
        $0.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    let instructionLabel = UILabel().then {
        $0.text = "연바에게 목소리를 들려주세요!"
        $0.font = UIFont.pretendardBold(size: 26)
        $0.textAlignment = .center
    }
    
    let detailLabel = UILabel().then {
        $0.text = "녹음한 목소리로 음역대를 측정해 드려요."
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
        $0.textColor = .gray
    }
    
    let recordingTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textAlignment = .center
    }
    
    let recordButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .light)
        let image = UIImage(systemName: "mic.circle.fill", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.backgroundColor = .white
        $0.tintColor = UIColor.primary
        $0.layer.cornerRadius = 33.5
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor(hex: "FF2149").cgColor
        $0.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
    }
    
    var audioRecorder: AVAudioRecorder?
    var recordingTimer: Timer?
    var recordingDuration: TimeInterval = 0
    let maxRecordingDuration: TimeInterval = 10
    let model =  try? converted_model(configuration: MLModelConfiguration())
    var result : Int?  = 1
    var voiceMode : String = "중음"
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWaveformView()
        setupUI()
        addSubViews()
        configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - Setup
    func setupUI() {
        setupBGColor()
        setupRecording()
    }
    
    // MARK: - UI Layout
    func addSubViews() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(recordingIndicatorView)
        view.addSubview(recordingLabel)
        view.addSubview(profileImageBGView)
        view.addSubview(profileImageView)
        view.addSubview(instructionLabel)
        view.addSubview(detailLabel)
        view.addSubview(recordingTimeLabel)
        view.addSubview(recordButton)
        view.addSubview(waveformView)
    }
    
    func configUI() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(21)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        
        recordingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(171)
            make.centerX.equalToSuperview()
        }
        
        recordingIndicatorView.snp.makeConstraints { make in
            make.centerY.equalTo(recordingLabel.snp.centerY)
            make.trailing.equalTo(recordingLabel.snp.leading).offset(-4)
            make.width.height.equalTo(10)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(218)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(159)
        }
        
        profileImageBGView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(209)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(175)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
        recordingTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(64)
            make.centerX.equalToSuperview()
        }
        
        waveformView.snp.makeConstraints { make in
            make.top.equalTo(recordingTimeLabel.snp.bottom).offset(20) // recordingTimeLabel 아래에 위치하도록 설정
            make.leading.trailing.equalToSuperview() // 화면의 가로폭에 맞게 설정
            make.height.equalTo(54) // 원하는 높이로 설정
        }
        
        recordButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-55)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(67)
        }
        
        
    }
    func setupBGColor() {
        let gradientLayer = CAGradientLayer()
        
        // 그라데이션 레이어 크기 설정
        gradientLayer.frame = self.view.bounds
        
        // 그라데이션 색상 설정 (FFFFFF와 FFE3E3을 CGColor로 변환)
        gradientLayer.colors = [UIColor(hex: "FFFFFF").cgColor, UIColor(hex: "FFE3E3").cgColor]
        
        // 그라데이션 방향 설정 (위에서 아래로)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        // 그라데이션 레이어를 뷰의 백그라운드로 설정
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Actions
    func setupRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentPath.appendingPathComponent("recording.m4a")
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
        } catch {
            print("Error setting up audio recording: \(error.localizedDescription)")
        }
    }
    private func startRecording() {
        // 권한
        AVAudioSession.sharedInstance().requestRecordPermission { (accepted) in
            if accepted {
                print("permission granted")
            }
        }
        // 녹음 시작
        recordingLabel.isHidden = false
        recordingIndicatorView.isHidden = false
        audioRecorder?.record()
        recordButton.backgroundColor = UIColor.clear
        recordButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        recordButton.tintColor = UIColor.primary
        // Start updating waveform view with audio level
        startRecordingTimer()
        startUpdatingWaveform()
    }
    private func stopRecording() {
        // 녹음 중지
        audioRecorder?.stop()
        stopRecordingTimer()
        if let audioFile = try? AVAudioFile(forReading: audioRecorder!.url){
            if let audioFormat = try? AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: audioFile.fileFormat.sampleRate, channels: 1, interleaved: false){
                let pcmBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: AVAudioFrameCount(audioFile.length))
                let mpcmBuffer =  computeMFCC(audioBuffer: pcmBuffer!)
                if let multiArray = preprocessData(data: mpcmBuffer!) {
                    print("MultiArray:", multiArray)
                    do {
                        let output = try model!.prediction(conv2d_input: multiArray)
                        result = argmax(output.IdentityShapedArray.strides)
                        switch result {
                        case 0 :
                            voiceMode = "저음"
                            SignDataManager.shared.vocalRange = voiceMode
                        case 1 :
                            voiceMode = "중음"
                            SignDataManager.shared.vocalRange = voiceMode
                        case 2 :
                            voiceMode = "고음"
                            SignDataManager.shared.vocalRange = voiceMode
                        case .none:
                            voiceMode = "중음"
                            SignDataManager.shared.vocalRange = voiceMode
                        case .some(_):
                            voiceMode = "중음"
                            SignDataManager.shared.vocalRange = voiceMode
                        }
                        print("현재 내 목소리: \(String(describing: SignDataManager.shared.vocalRange))")
                    } catch {
                        print("모델 예측 도중 오류가 발생했습니다: \(error.localizedDescription)")
                    }
                }
            }
        }
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .light)
        let image = UIImage(systemName: "mic.circle.fill", withConfiguration: imageConfig)
        recordButton.setImage(image, for: .normal)
        recordButton.backgroundColor = .white
        recordButton.tintColor = UIColor.primary
        presentPopup()
    }
    func argmax<T: Comparable>(_ array: [T]) -> Int? {
        guard !array.isEmpty else { return nil }
        
        var maxIndex = 0
        var maxValue = array[0]
        
        for (index, value) in array.enumerated() {
            if value > maxValue {
                maxIndex = index
                maxValue = value
            }
        }
        
        return maxIndex
    }

    private func startRecordingTimer() {
        recordingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.recordingDuration += 1
            self?.updateRecordingTimeLabel()
            if self!.recordingDuration >= self!.maxRecordingDuration  {
                self?.stopRecording()
            }
        }
    }
    private func stopRecordingTimer() {
        recordingTimer?.invalidate()
        recordingTimer = nil
        if let audioURL = audioRecorder?.url {
            print("녹음이 완료되었습니다. 녹음 파일의 URL: \(audioURL)")
        }
    }
    
    private func updateRecordingTimeLabel() {
        let minutes = Int(recordingDuration) / 60
        let seconds = Int(recordingDuration) % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        DispatchQueue.main.async { [weak self] in
            self?.recordingTimeLabel.text = formattedTime
        }
    }
    private func startUpdatingWaveform() {
        let timer = Timer(timeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateAudioLevel()
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func setupWaveformView() {
        waveformView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 54)
    }
    
    private func updateAudioLevel() {
        audioRecorder!.updateMeters() // Update metering levels
        let decibels = audioRecorder!.averagePower(forChannel: 0) // Get average power in decibels
        let normalizedLevel = pow(10, decibels / 20) // Normalize decibels to a value between 0 and 1
        
        DispatchQueue.main.async { [weak self] in
            self?.waveformView.update(withLevel: CGFloat(normalizedLevel))
        }
    }
    
    func presentPopup() {
        // 팝업 뷰 컨트롤러를 생성하고 모달로 띄웁니다.
        let popupViewController = VoicePopupViewcontroller(title: "연방님은 \(voiceMode)입니다!", desc: "연방님은 \(voiceMode)의 음역대를 가지고 계시군요!\n\(voiceMode)의 목소리를 이성에게 어필해 보세요!", navigation: navigationController)
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
    }
    
    @objc func recordButtonTapped() {
        // 권한
        AVAudioSession.sharedInstance().requestRecordPermission { (accepted) in
            if accepted {
                print("permission granted")
            }
        }
        if let recorder = audioRecorder {
            if recorder.isRecording {
                stopRecording()
            } else {
                startRecording()
            }
        }
    }
    
    @objc func backButtonTapped() {
        // 뒤로 가기 로직을 구현
        dismiss(animated: true, completion: nil)
    }
    
    
    //AI 모델 관련 코드

    func preprocessData(data: [Float]) -> MLMultiArray? {
        let paddedData = padData(data: data, targetLength: 800000)
        let reshapedData = reshapeData(data: paddedData, rows: 8, columns: 100000)
        return convertToMultiArray(data: reshapedData)
    }

    func padData(data: [Float], targetLength: Int) -> [Float] {
        var paddedData = data
        if data.count < targetLength {
            let paddingCount = targetLength - data.count
            paddedData += [Float](repeating: 0, count: paddingCount)
        }
        return paddedData
    }
    //차원 변경
    func reshapeData(data: [Float], rows: Int, columns: Int) -> [[Float]] {
        var reshapedData = [[Float]]()
        for i in 0..<rows {
            let startIndex = i * columns
            let endIndex = (i + 1) * columns
            let row = Array(data[startIndex..<endIndex])
            reshapedData.append(row)
        }
        return reshapedData
    }
    //모델에 넣기 위한 변환
    func convertToMultiArray(data: [[Float]]) -> MLMultiArray? {
        let multiArray = try? MLMultiArray(shape: [1, 8, 100000, 1] as [NSNumber], dataType: .float32)
        let range = NSRange(location: 0, length: data.count * data[0].count)
        multiArray?.dataPointer.withMemoryRebound(to: Float.self, capacity: data.count * data[0].count) { pointer in
            pointer.assign(from: data.flatMap { $0 }, count: data.count * data[0].count)
        }
        return multiArray
    }
    //오디오를 버퍼로 변환후  MFCC 변환을 위한 함수
    func computeMFCC(audioBuffer: AVAudioPCMBuffer) -> [Float]? {
        let sampleRate = audioBuffer.format.sampleRate
        let frameLength = vDSP_Length(0.025 * Double(sampleRate)) // Frame length (25ms)
        let frameStep = vDSP_Length(0.01 * Double(sampleRate)) // Frame step (10ms)
        
        guard let audioData = audioBuffer.floatChannelData?.pointee else {
            return nil
        }
        
        let audioDataCount = Int(audioBuffer.frameLength)
        
        // Split audio data into frames
        var frames = [Array<Float>]()
        var i = 0
        while i + Int(frameLength) <= audioDataCount {
            let frame = Array(arrayLiteral: audioData[i])
            frames.append(frame)
            i += Int(frameStep)
        }
        
        // Pre-emphasis (optional)
        let preEmphasisCoeff: Float = 0.97
        var preEmphasizedFrames = frames.map { frame -> [Float] in
            var outputFrame = [Float](repeating: 0.0, count: frame.count)
            outputFrame[0] = frame[0]
            for i in 1..<frame.count {
                outputFrame[i] = frame[i] - preEmphasisCoeff * frame[i - 1]
            }
            return outputFrame
        }
        
        // Hamming window
        var window = [Float](repeating: 0.0, count: Int(frameLength))
        vDSP_hann_window(&window, vDSP_Length(frameLength), Int32(vDSP_HANN_NORM))
        
        // Apply Hamming window to frames
        for i in 0..<preEmphasizedFrames.count {
            var frame = preEmphasizedFrames[i]
            vDSP_vmul(frame, 1, window, 1, &frame, 1, vDSP_Length(frameLength))
            preEmphasizedFrames[i] = frame
        }
        // DCT를 위한 설정 생성
        var setup: vDSP_DFT_Setup? = vDSP_DFT_CreateSetup(nil, vDSP_Length(frameLength))
        defer {
            vDSP_DFT_DestroySetup(setup)
        }
        
        
        // Compute MFCCs
        var mfccs = [Float]()
        for frame in preEmphasizedFrames {
            // frame을 DCT로 변환하여 mfcc 계산
            var dctInput = frame
            var dctOutput = [Float](repeating: 0, count: Int(frameLength))
            vDSP_DCT_Execute(setup!, &dctInput, &dctOutput)
            
            // 계산된 MFCC를 mfccs 배열에 추가
            mfccs.append(contentsOf: dctOutput)
        }
        
        return mfccs
    }
    
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
extension UIFont {
    static func pretendardMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Pretendard-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        return font
    }
    static func pretendardBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Pretendard-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
    static func pretendardExtraBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Pretendard-ExtraBold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
}
