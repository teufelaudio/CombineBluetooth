import CoreBluetooth

extension CBPeer: @retroactive Identifiable {
    public var id: UUID { identifier }
}

extension CBService: @retroactive Identifiable {
    public var id: CBUUID { uuid }
}

extension CBCharacteristic: @retroactive Identifiable {
    public var id: CBUUID { uuid }
}

extension CBDescriptor: @retroactive Identifiable {
    public var id: CBUUID { uuid }
}
