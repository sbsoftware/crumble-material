# crumble-material

TODO: Write a description here

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     crumble-material:
       github: your-github-user/crumble-material
   ```

2. Run `shards install`

## Usage

```crystal
require "crumble-material"
```

Include the shard stylesheets in your layout as usual. All CSS emitted by this shard is wrapped in `@layer crumble-material`.

If your app defines cascade layer order up front, declare the shard layer before your app overrides so local styles can win without selector hacks:

```css
@layer reset, crumble-material, app;
```

Place your own component overrides in `@layer app` or any layer ordered after `crumble-material`.

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/crumble-material/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Stefan Bilharz](https://github.com/your-github-user) - creator and maintainer
