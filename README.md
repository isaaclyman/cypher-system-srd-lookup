# Development

## Generating JSON deserialization code

This is necessary whenever `lib/types.dart` is changed.

```sh
cd cli
dart run build_runner build
```

## Checking JSON deserialization

```sh
cd cli
dart run :decode
```

## Shout-outs

Thanks to Jon Davis for his hard work compiling the Cypher System SRD to [JSON format](https://github.com/Jon-Davis/Cypher-System-JSON-DB). The SQLite database in this project is based on his work.