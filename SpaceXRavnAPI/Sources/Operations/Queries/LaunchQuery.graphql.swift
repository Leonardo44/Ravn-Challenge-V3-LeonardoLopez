// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LaunchQuery: GraphQLQuery {
  public static let operationName: String = "Launch"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Launch($launchId: ID!) { launch(id: $launchId) { __typename id mission_name launch_date_utc launch_date_local details links { __typename video_link wikipedia } } }"#
    ))

  public var launchId: ID

  public init(launchId: ID) {
    self.launchId = launchId
  }

  public var __variables: Variables? { ["launchId": launchId] }

  public struct Data: SpaceXRavnAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpaceXRavnAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("launch", Launch?.self, arguments: ["id": .variable("launchId")]),
    ] }

    public var launch: Launch? { __data["launch"] }

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
        .field("details", String?.self),
        .field("links", Links?.self),
      ] }

      public var id: SpaceXRavnAPI.ID? { __data["id"] }
      public var mission_name: String? { __data["mission_name"] }
      public var launch_date_utc: SpaceXRavnAPI.Date? { __data["launch_date_utc"] }
      public var launch_date_local: SpaceXRavnAPI.Date? { __data["launch_date_local"] }
      public var details: String? { __data["details"] }
      public var links: Links? { __data["links"] }

      /// Launch.Links
      ///
      /// Parent Type: `LaunchLinks`
      public struct Links: SpaceXRavnAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpaceXRavnAPI.Objects.LaunchLinks }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("video_link", String?.self),
          .field("wikipedia", String?.self),
        ] }

        public var video_link: String? { __data["video_link"] }
        public var wikipedia: String? { __data["wikipedia"] }
      }
    }
  }
}
