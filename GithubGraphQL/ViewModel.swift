import Apollo

final class ViewModel {
  private let client: GraphQLClient

  init(client: GraphQLClient = ApolloClient.shared) {
    self.client = client
  }

  func search(phrase: String) {
    /*
     example search of a given phrase, using default searching parameters
     */

    self.client.searchRepositories(mentioning: phrase) { response in
      switch response {
      case let .failure(error):
        print(error)

      case let .success(results):
        let pageInfo = results.pageInfo
        print("pageInfo: \n")
        print("hasNextPage: \(pageInfo.hasNextPage)")
        print("hasPreviousPage: \(pageInfo.hasPreviousPage)")
        print("startCursor: \(String(describing: pageInfo.startCursor))")
        print("endCursor: \(String(describing: pageInfo.endCursor))")
        print("\n")

        results.repos.forEach { repository in
          print("Name: \(repository.name)")
          print("Path: \(repository.url)")
          print("Owner: \(repository.owner.login)")
          print("avatar: \(repository.owner.avatarUrl)")
          print("Stars: \(repository.stargazers.totalCount)")
          print("\n")
        }
      }
    }
  }
}
