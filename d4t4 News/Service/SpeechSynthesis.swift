//
//  SpeechSynthesis.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation
import AVFoundation

class SpeechSynthesisService {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(text: String) {
        print("Attempting to speak: \(text)")
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        synthesizer.speak(utterance)
    }
}
