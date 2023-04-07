# <%= name %>

This stack was generated with [Nx](https://nx.dev).

## Running unit tests

Run `npm run nx test <%= name %>` to execute the unit tests via [Jest](https://jestjs.io).

For detailed test output or watch mode run `cd services/<%= fileName %> && jest --watch`.

## Architecture

This service uses an event-driven, serverless architecture with event-sourced aggregates and separation
between "Write Model" and "Read Model" (CQRS).

The architecture is documented on the [Serverless Architecture](https://app.prooph-board.com/inspectio/board/4f108fb9-5c68-42c4-984e-664a2dbccf52)
prooph board.

## Service Structure

```bash
|__ async                   # Root directory for asynchronous event-driven communication
  |__ consuming             # Events consumed by the service
  |__ listeners             # Process manager or policy functions: If [event] Then [command]
    |__ index.tx            # Event Dispatcher mapping Event -> Listener[]
  |__ producing             # Public events produced by the service
|__ command-bus             # Command dispatch functions
  |__ providers             # Dependency and data providers used to inject dependencies into command handlers
|__ http                    # HTTP request handling Lambda functions called by AWS API Gateway
|__ model                   # Root folder for the Write Model e.g. all aggregates
  |__ [Aggregate]           # Each Aggregate has its own directory in the Write Model
    |__ commands            # All commands handled by the aggregate
    |__ events              # All events recorded by the aggregate
    |__ handlers            # All command handling functions of the aggregate
    |__ reducers            # All event apply methods of the aggregate
    |__ [Aggregate].ts      # Aggregate type and state factory function
    |__ repository.ts       # Aggregate repository definition and configured instance
|__ read-model              # Read Model root directory
  |__ projections           # All read model projections
  |__ queries               # All queries of the service
  |__ resolvers             # All query resolvers of the service
  |__ types                 # Type definitions of Read Model
```
