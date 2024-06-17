import Foundation

class MulticastDelegate<T: NSObjectProtocol> {
    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    private let lock = NSLock()
    
    var isEmpty: Bool {
        delegates.allObjects.isEmpty
    }
    
    public func add(_ delegate: T) {
        lock.lock()
        defer { lock.unlock() }
        delegates.add(delegate as AnyObject)
    }

    public func remove(_ delegate: T) {
        lock.lock()
        defer { lock.unlock() }
        delegates.remove(delegate)
    }
    
    public func invoke(_ invocation: (T) -> Void) {
        lock.lock()
        defer { lock.unlock() }
        for delegate in delegates.allObjects {
            invocation(delegate as! T)
        }
    }
}
