//
//  AppStorage+Extensions.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 08.07.24.
//

import SwiftUI

public extension AppStorage {
    /// A way to use `AppStorage` with more types,
    /// via conversion to and from the limited supported types.
    typealias Converter<Converted> = StorageConverter<Self, Converted>
}

// MARK: - StorageDynamicProperty
extension AppStorage: StorageDynamicProperty { }

// MARK: - Double
public extension AppStorage<Double>.Converter where Storage == AppStorage<Double> {
    init(
        wrappedValue: Converted,
        _ key: String,
        store: UserDefaults? = nil,
        fromStorage: @escaping FromStorage,
        toStorage: @escaping ToStorage
    ) {
        self.init(
            storage: .init(wrappedValue: toStorage(wrappedValue), key, store: store),
            fromStorage: fromStorage, toStorage: toStorage
        )
    }
}

public extension AppStorage<Double>.Converter<Date> {
    init(
        wrappedValue: Converted,
        _ key: String,
        store: UserDefaults? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            key,
            store: store,
            fromStorage: Date.init(timeIntervalSinceReferenceDate:),
            toStorage: \.timeIntervalSinceReferenceDate
        )
    }
}


@propertyWrapper public struct StorageConverter<Storage: StorageDynamicProperty, Converted> {
    public typealias ToStorage = (Converted) -> Storage.Value
    public typealias FromStorage = (Storage.Value) -> Converted
    
    public var wrappedValue: Converted {
        get { fromStorage(storage.wrappedValue) }
        nonmutating set { storage.wrappedValue = toStorage(newValue) }
    }
    
    public var projectedValue: Binding<Converted> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    // MARK: internal
    init(
        storage: Storage,
        fromStorage: @escaping FromStorage,
        toStorage: @escaping ToStorage
    ) {
        self.storage = storage
        self.toStorage = toStorage
        self.fromStorage = fromStorage
    }
    
    // MARK: private
    private let storage: Storage
    private let fromStorage: FromStorage
    private let toStorage: ToStorage
}

public protocol StorageDynamicProperty<Value>: DynamicProperty {
    associatedtype Value
    var wrappedValue: Value { get nonmutating set }
}

// MARK: - DynamicProperty
extension StorageConverter: DynamicProperty { }
