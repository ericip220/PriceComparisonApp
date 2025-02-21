import SwiftUI
import Speech
import AVFoundation

struct SearchBar: View {
    @Binding var searchText: String
    let onSearch: () -> Void
    
    @State private var isRecording = false
    @State private var speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()
    
    var body: some View {
        HStack(spacing: 10) {
            // TextField and mic button
            HStack {
                TextField("Search for products...", text: $searchText)
                    .padding(.leading, 20)
                    .frame(width: 280, height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray, lineWidth: 4)
                    )
                Button(action: {
                    isRecording ? stopRecording() : startRecording()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(hue: 0.152, saturation: 0.396, brightness: 0.991))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                            )
                        Image(systemName: isRecording ? "mic.slash.fill" : "mic.fill")
                            .foregroundColor(Color.gray)
                            .frame(width: 38, height: 38)
                    }
                }
            }
            .frame(height: 40)
            
            // Magnifying glass button
            Button(action: {
                onSearch()
            }) {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 4)
                        )
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .foregroundColor(Color.orange)
                        .frame(width: 38, height: 38)
                }
            }
            .padding(.trailing, 10)
        }
        .padding()
        .onAppear {
            requestAuthorization()
        }
    }
    
    private func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("Speech recognition authorized")
                case .denied:
                    print("Speech recognition authorization denied")
                    // Show an alert to the user
                    showAlert(title: "Permission Denied", message: "Please enable speech recognition in Settings.")
                case .restricted:
                    print("Speech recognition restricted on this device")
                    // Show an alert to the user
                    showAlert(title: "Permission Restricted", message: "Speech recognition is restricted on this device.")
                case .notDetermined:
                    print("Speech recognition not determined")
                @unknown default:
                    print("Unknown authorization status")
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .filter({ $0.isKeyWindow }).first {
                keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func startRecording() {
        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            print("Speech recognizer is not available")
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            print("Unable to create recognition request")
            return
        }
        
        let inputNode = audioEngine.inputNode
        guard let recordingFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1) else {
            print("Invalid audio format")
            return
        }
        
        // Ensure format sample rate and channel count are valid
        guard recordingFormat.sampleRate > 0 && recordingFormat.channelCount > 0 else {
            print("Invalid audio format")
            return
        }
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            print("Audio engine started")
        } catch {
            print("Audio engine couldn't start: \(error.localizedDescription)")
            return
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                self.searchText = result.bestTranscription.formattedString
            }
            if error != nil || result?.isFinal == true {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.isRecording = false
                print("Recording stopped")
            }
        }
        
        isRecording = true
        print("Recording started")
    }
    
    private func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        isRecording = false
        print("Recording stopped manually")
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), onSearch: {})
    }
}
