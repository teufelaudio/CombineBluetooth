import CoreBluetooth

private let identifierKey = "identifier"

extension CBCentral: Identifiable {
    public var id: UUID {
        return value(forKey: identifierKey) as! NSUUID as UUID
    }
}

extension CBPeripheral: Identifiable {
    public var id: UUID {
        value(forKey: identifierKey) as! NSUUID as UUID
    }
}

extension CBService: Identifiable {
    public var id: CBUUID {
        self.uuid
    }
}

extension CBCharacteristic: Identifiable {
    public var id: CBUUID {
        self.uuid
    }
}

extension CBDescriptor: Identifiable {
    public var id: CBUUID {
        self.uuid
    }
}
