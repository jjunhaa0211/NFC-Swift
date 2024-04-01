import Foundation
import CoreNFC

class NFCManager: NSObject {
    // 태그 감지용
    private var session: NFCNDEFReaderSession?
    
    // 감지되었을 때 호출하는 클래스
    private let didDetectTag: (NFCNDEFMessage) -> Void
    // 에러났을 때 호출되는 클래스
    private let didInvalidateWithError: (Error) -> Void
    
    init(didDetectTag: @escaping (NFCNDEFMessage) -> Void,
         didInvalidateWithError: @escaping (Error) -> Void
    ) {
        self.didDetectTag = didDetectTag
        self.didInvalidateWithError = didInvalidateWithError
        
        super.init()
    }
    
    // 태그 감지용 메서드
    func startLookingForTag() {
        self.session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        self.session?.begin()
    }
}

extension NFCManager: NFCNDEFReaderSessionDelegate {
    
    // 실패했을 떄 호출
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        self.didInvalidateWithError(error)
    }
    
    // 감지 되었을 떄 호출
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            self.didDetectTag(message)
        }
    }
}
