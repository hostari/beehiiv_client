# Beehiiv

![Shard CI](https://github.com/hostari/beehiiv_client/workflows/Shard%20CI/badge.svg)
[![API Documentation Website](https://img.shields.io/website?down_color=red&down_message=Offline&label=API%20Documentation&up_message=Online&url=https%3A%2F%2Fhostari.github.io%2Fbeehiiv_client%2F)](https://hostari.github.io/beehiiv_client)
[![GitHub release](https://img.shields.io/github/release/hostari/beehiiv_client.svg?label=Release)](https://github.com/hostari/beehiiv_client/releases)

Beehiiv API wrapper for Crystal.

This version (>1.0) is changed to follow Ruby's method and class structure. We will follow `Stripe::Class.method` but follow crystal parameters to take care of the types automatically.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  beehiiv:
    github: hostari/beehiiv_client
```

## Contributing

1. Fork it (<https://github.com/hostari/beehiiv_client/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
