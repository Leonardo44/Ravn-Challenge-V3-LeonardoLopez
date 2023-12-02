// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LaunchesQuery: GraphQLQuery {
  public static let operationName: String = "Launches"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Launches { launches { __typename id mission_name launch_date_utc launch_date_local } }"#
    ))

  public init() {}

  public struct Data: SpaceXRavnAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpaceXRavnAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("launches", [Launch?]?.self),
    ] }

    public var launches: [Launch?]? { __data["launches"] }

    /// Launch
    ///
    /// Parent Type: `Launch`
    public struct Launch: SpaceXRavnAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpaceXRavnAPI.Objects.Launch }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", SpaceXRavnAPI.ID?.self),
        .field("mission_name", String?.self),
        .field("launch_date_utc", SpaceXRavnAPI.Date?.self),
        .field("launch_date_local", SpaceXRavnAPI.Date?.self),
      ] }

      public var id: SpaceXRavnAPI.ID? { __data["id"] }
      public var mission_name: String? { __data["mission_name"] }
      public var launch_date_utc: SpaceXRavnAPI.Date? { __data["launch_date_utc"] }
      public var launch_date_local: SpaceXRavnAPI.Date? { __data["launch_date_local"] }
    }
  }
}
