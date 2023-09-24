# Cypher SRD Quick Lookup

An instant full-text search app for the Cypher System SRD with structured results.

# Get the app

Visit [isaaclyman.com/cypher-system-srd-lookup](https://isaaclyman.com/cypher-system-srd-lookup/) for links to download on the App Store and Google Play.

# Support

If there's a problem with the app or one of the entries in it, you may [file an issue](https://github.com/isaaclyman/cypher-system-srd-lookup/issues).

If you'd like me to spend more time on this app (meaning more free features for everyone), simply [sponsor me](https://ko-fi.com/isaaclyman).

# Contributing

Before submitting a PR, please file an issue describing the feature or fix you'd like to work on. This will help me coordinate with any ongoing work by me or other contributors.

# Development

## Generating JSON deserialization code

This is necessary whenever `lib/json_data/types.dart` or `assets/CSRD.json` is changed.

```sh
dart run build_runner build
```

## Checking JSON deserialization

```sh
dart run :decode
```

## Shout-outs

Thanks to Jon Davis for his hard work compiling the Cypher System SRD to [JSON format](https://github.com/Jon-Davis/Cypher-System-JSON-DB).