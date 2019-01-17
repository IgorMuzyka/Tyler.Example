import FluentSQLite
import Vapor
import TypePreservingCodingAdapter
import Tyler

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentSQLiteProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)


    var contentConfig = ContentConfig.default()
    contentConfig.use(encoder: Tyler.encoder, for: .json)
    contentConfig.use(decoder: Tyler.decoder, for: .json)
    services.register(contentConfig)

    let server = NIOServerConfig(hostname: "0.0.0.0",
                                 port: 8080,
                                 backlog: 256,
                                 workerCount: ProcessInfo.processInfo.activeProcessorCount,
                                 maxBodySize: 1_000_000,
                                 reuseAddress: true,
                                 tcpNoDelay: true,
                                 webSocketMaxFrameSize: 1 << 14)
    services.register(server)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .sqlite)
    migrations.add(migration: PrepopulateDatabase.self, database: .sqlite)
    services.register(migrations)

}
