import CoreBluetooth

extension CBPeer: Identifiable {
    public var id: UUID { identifier }
}

extension CBService: Identifiable {
    public var id: CBUUID { uuid }
}

extension CBCharacteristic: Identifiable {
    public var id: CBUUID { uuid }
}

extension CBDescriptor: Identifiable {
    public var id: CBUUID { uuid }
}
