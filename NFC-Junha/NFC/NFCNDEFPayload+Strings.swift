import CoreNFC

extension String {
    static func fromData(data: Data) -> String? {
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        
        if let string = String(data: data, encoding: .ascii) {
            return string
        }
        
        return nil
    }
}

extension NFCNDEFPayload {
    
    func typeNameFormatString() -> String {
        switch self.typeNameFormat {
        case .empty:
            return "빈 NFC 타입 이름 형식"
        case .nfcWellKnown:
            return "NFC Well Known 타입 이름 형식"
        case .media:
            return "미디어 타입 이름 형식"
        case .absoluteURI:
            return "절대 URI 타입 이름 형식"
        case .nfcExternal:
            return "외부 NFC 타입 이름 형식"
        case .unknown:
            return "알 수 없는 NFC 타입 이름 형식"
        case .unchanged:
            return "변경되지 않은 NFC 타입 이름 형식"
        @unknown default:
            return "없음"
        }
    }
    
    func identifierString() -> String? {
        return String.fromData(data: self.identifier)
    }
    
    func typeString() -> String? {
        return String.fromData(data: self.type)
    }
    
    func payloadString() -> String? {
        return String.fromData(data: self.payload)
    }
}
