//
//  ActivityClient.swift
//  DomainActivityInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

public struct ActivityClient {
  public var fetchAll: @Sendable () throws -> [Activity]
  public var fetch: @Sendable (FetchDescriptor<Activity>) throws -> [Activity]
  public var add: @Sendable (Activity) throws -> Void
  public var delete: @Sendable (Activity) throws -> Void
  
  public init(
    fetchAll: @Sendable @escaping () -> [Activity],
    fetch: @Sendable @escaping (FetchDescriptor<Activity>) -> [Activity],
    add: @Sendable @escaping (Activity) -> Void,
    delete: @Sendable @escaping (Activity) -> Void
  ) {
    self.fetchAll = fetchAll
    self.fetch = fetch
    self.add = add
    self.delete = delete
  }
}

extension ActivityClient: TestDependencyKey {
  public static var testValue = Self(
    fetchAll: unimplemented("\(Self.self).fetchAll"),
    fetch: unimplemented("\(Self.self).fetch"),
    add: unimplemented("\(Self.self).add"),
    delete: unimplemented("\(Self.self).delete")
  )
}
