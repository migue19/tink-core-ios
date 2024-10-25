import Foundation

public protocol StatisticService {
    func statistics(
        description: String?,
        periods: [StatisticPeriod],
        types: [Statistic.Kind],
        resolution: Statistic.Resolution,
        padResultsUntilToday: Bool,
        completion: @escaping (Result<[Statistic], Error>) -> Void
    ) -> Cancellable?
}
