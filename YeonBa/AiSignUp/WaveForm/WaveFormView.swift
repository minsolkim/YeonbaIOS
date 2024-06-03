//
//  WaveFormView.swift
//  YeonBa
//
//  Created by jin on 4/15/24.
//

import UIKit

class WaveformView: UIView {
    private var levels: [CGFloat] = [] // 오디오 레벨 배열

    func update(withLevel level: CGFloat) {
        levels.append(level)

        // 최대 저장할 수 있는 오디오 레벨 개수를 정하고, 그 이상이면 맨 처음의 레벨을 제거
        if levels.count > 100 {
            levels.removeFirst()
        }
        
        setNeedsDisplay() // 뷰를 다시 그리도록 설정
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.clear(rect)
        
        // 중앙 기준선을 그립니다.
        let midY = rect.height / 2
        let amplitude = midY - 4 // 파형의 최대 진폭

        // 파형의 색상과 라인 너비 설정
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)

        // 각 레벨에 대한 파형을 그립니다.
        let widthPerLevel = rect.width / CGFloat(levels.count)
        for (index, level) in levels.enumerated() {
            let x = CGFloat(index) * widthPerLevel
            let lineHeight = amplitude * level
            context.move(to: CGPoint(x: x, y: midY - lineHeight / 2))
            context.addLine(to: CGPoint(x: x, y: midY + lineHeight / 2))
        }
        
        context.strokePath() // 그린 파형을 캔버스에 표시
    }
}
